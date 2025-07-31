#!/bin/bash

# Go Gateway Docker Build Script
set -e

echo "🐳 Go Gateway Docker Build Script"
echo "================================"

# 设置变量
PROJECT_NAME="go-gateway"
VERSION=${1:-"latest"}
REGISTRY=${DOCKER_REGISTRY:-""}

echo "📦 Building version: $VERSION"
echo "🏷️  Registry: ${REGISTRY:-"local"}"

# 函数：构建Docker镜像
build_image() {
    local component=$1
    local dockerfile=$2
    local tag="${PROJECT_NAME}-${component}:${VERSION}"
    
    if [ -n "$REGISTRY" ]; then
        tag="${REGISTRY}/${tag}"
    fi
    
    echo ""
    echo "🔨 Building $component..."
    echo "   Dockerfile: $dockerfile"
    echo "   Tag: $tag"
    
    docker build \
        --build-arg VERSION=$VERSION \
        --build-arg BUILD_TIME=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
        --build-arg GIT_COMMIT=$(git rev-parse HEAD 2>/dev/null || echo "unknown") \
        -f $dockerfile \
        -t $tag \
        .
    
    echo "✅ Successfully built $tag"
    
    # 同时打latest标签
    if [ "$VERSION" != "latest" ]; then
        local latest_tag="${PROJECT_NAME}-${component}:latest"
        if [ -n "$REGISTRY" ]; then
            latest_tag="${REGISTRY}/${latest_tag}"
        fi
        docker tag $tag $latest_tag
        echo "🏷️  Tagged as $latest_tag"
    fi
}

# 函数：推送镜像
push_images() {
    if [ -n "$REGISTRY" ]; then
        echo ""
        echo "📤 Pushing images to registry..."
        docker push "${REGISTRY}/${PROJECT_NAME}-dashboard:${VERSION}"
        docker push "${REGISTRY}/${PROJECT_NAME}-server:${VERSION}"
        
        if [ "$VERSION" != "latest" ]; then
            docker push "${REGISTRY}/${PROJECT_NAME}-dashboard:latest"
            docker push "${REGISTRY}/${PROJECT_NAME}-server:latest"
        fi
        echo "✅ Images pushed successfully"
    fi
}

# 函数：显示镜像信息
show_images() {
    echo ""
    echo "📋 Built images:"
    docker images | grep $PROJECT_NAME | head -10
}

# 主构建流程
echo ""
echo "🔧 Preparing build environment..."

# 检查Docker是否运行
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# 检查Git（用于获取commit信息）
if ! command -v git >/dev/null 2>&1; then
    echo "⚠️  Git not found. Build will continue without git commit info."
fi

# 清理旧的构建文件
echo "🧹 Cleaning old builds..."
rm -rf ./bin/go_gateway

# 设置Go环境
export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct

# 整理依赖
echo "📦 Tidying Go modules..."
go mod tidy

# 构建本地二进制（用于测试）
echo "🔨 Building local binary for testing..."
GOOS=linux GOARCH=amd64 go build -o ./bin/go_gateway main.go

# 构建Docker镜像
build_image "dashboard" "dockerfile-dashboard"
build_image "server" "dockerfile-server"

# 推送镜像（如果指定了registry）
if [ "$2" = "--push" ]; then
    push_images
fi

# 显示构建结果
show_images

echo ""
echo "🎉 Build completed successfully!"
echo ""
echo "Usage:"
echo "  Run dashboard: docker run -p 8880:8880 ${PROJECT_NAME}-dashboard:${VERSION}"
echo "  Run server:    docker run -p 8081-8084:8081-8084 ${PROJECT_NAME}-server:${VERSION}"
echo ""

# 保存构建信息
cat > build_info.txt << EOF
Build Information
=================
Version: $VERSION
Build Time: $(date -u +'%Y-%m-%dT%H:%M:%SZ')
Git Commit: $(git rev-parse HEAD 2>/dev/null || echo "unknown")
Docker Images:
- ${PROJECT_NAME}-dashboard:${VERSION}
- ${PROJECT_NAME}-server:${VERSION}
EOF

echo "💾 Build information saved to build_info.txt"