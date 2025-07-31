#!/bin/bash

# Docker Compose管理脚本
set -e

echo "🐳 Go Gateway Docker Compose管理脚本"
echo "===================================="

COMPOSE_FILE="docker-compose.yml"
PROJECT_NAME="go-gateway"

# 函数：启动所有服务
start_all() {
    echo "🚀 启动所有服务..."
    docker-compose -p $PROJECT_NAME up -d
    
    echo "⏳ 等待服务启动..."
    sleep 10
    
    show_status
}

# 函数：启动基础服务（仅数据库）
start_base() {
    echo "🛢️ 启动基础服务（MySQL + Redis）..."
    docker-compose -p $PROJECT_NAME up -d mysql redis
    
    echo "⏳ 等待数据库启动..."
    sleep 15
    
    echo "✅ 基础服务启动完成"
}

# 函数：启动应用服务
start_apps() {
    echo "📊 启动应用服务..."
    docker-compose -p $PROJECT_NAME up -d dashboard server
    
    echo "⏳ 等待应用启动..."
    sleep 10
    
    show_status
}

# 函数：启动带Nginx的完整服务
start_full() {
    echo "🌐 启动完整服务（包括Nginx）..."
    docker-compose -p $PROJECT_NAME --profile nginx up -d
    
    echo "⏳ 等待服务启动..."
    sleep 15
    
    show_status
}

# 函数：停止所有服务
stop_all() {
    echo "🛑 停止所有服务..."
    docker-compose -p $PROJECT_NAME down
    echo "✅ 所有服务已停止"
}

# 函数：重启服务
restart() {
    echo "🔄 重启服务..."
    docker-compose -p $PROJECT_NAME restart
    
    echo "⏳ 等待服务重启..."
    sleep 10
    
    show_status
}

# 函数：查看状态
show_status() {
    echo ""
    echo "📊 服务状态："
    echo "============"
    docker-compose -p $PROJECT_NAME ps
    
    echo ""
    echo "🌐 访问地址："
    echo "============"
    echo "Dashboard: http://localhost:8880"
    echo "API文档:   http://localhost:8880/swagger/index.html"
    echo "HTTP代理:  http://localhost:8081"
    echo "HTTPS代理: https://localhost:8082"
    echo "TCP代理:   tcp://localhost:8083"
    echo "GRPC代理:  grpc://localhost:8084"
    echo ""
    echo "默认登录: admin/123456"
}

# 函数：查看日志
show_logs() {
    local service=$1
    if [ -z "$service" ]; then
        echo "📝 显示所有服务日志..."
        docker-compose -p $PROJECT_NAME logs -f
    else
        echo "📝 显示 $service 服务日志..."
        docker-compose -p $PROJECT_NAME logs -f $service
    fi
}

# 函数：进入容器
exec_container() {
    local service=$1
    if [ -z "$service" ]; then
        echo "❌ 请指定服务名称"
        echo "可用服务: mysql, redis, dashboard, server, nginx"
        exit 1
    fi
    
    echo "🔧 进入 $service 容器..."
    docker-compose -p $PROJECT_NAME exec $service sh
}

# 函数：清理所有数据
cleanup() {
    echo "🧹 清理所有数据..."
    read -p "⚠️  这将删除所有容器、网络和数据卷，确定吗？(y/N): " confirm
    
    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        docker-compose -p $PROJECT_NAME down -v --remove-orphans
        docker system prune -f
        echo "✅ 清理完成"
    else
        echo "❌ 取消清理"
    fi
}

# 函数：构建镜像
build_images() {
    echo "🔨 构建Docker镜像..."
    docker-compose -p $PROJECT_NAME build --no-cache
    echo "✅ 镜像构建完成"
}

# 函数：更新服务
update() {
    echo "🔄 更新服务..."
    build_images
    docker-compose -p $PROJECT_NAME up -d --force-recreate
    
    echo "⏳ 等待服务更新..."
    sleep 10
    
    show_status
}

# 函数：备份数据库
backup_db() {
    echo "💾 备份数据库..."
    local backup_file="backup_$(date +%Y%m%d_%H%M%S).sql"
    
    docker-compose -p $PROJECT_NAME exec -T mysql mysqldump -u root -p123456 go_gateway > $backup_file
    
    echo "✅ 数据库备份完成: $backup_file"
}

# 函数：恢复数据库
restore_db() {
    local backup_file=$1
    if [ -z "$backup_file" ]; then
        echo "❌ 请指定备份文件"
        exit 1
    fi
    
    if [ ! -f "$backup_file" ]; then
        echo "❌ 备份文件不存在: $backup_file"
        exit 1
    fi
    
    echo "📥 恢复数据库..."
    docker-compose -p $PROJECT_NAME exec -T mysql mysql -u root -p123456 go_gateway < $backup_file
    
    echo "✅ 数据库恢复完成"
}

# 函数：显示帮助
show_help() {
    echo "Usage: $0 {command} [options]"
    echo ""
    echo "Commands:"
    echo "  start      - 启动所有服务"
    echo "  start-base - 启动基础服务（MySQL + Redis）"
    echo "  start-apps - 启动应用服务（Dashboard + Server）"
    echo "  start-full - 启动完整服务（包括Nginx）"
    echo "  stop       - 停止所有服务"
    echo "  restart    - 重启服务"
    echo "  status     - 查看服务状态"
    echo "  logs [service] - 查看日志"
    echo "  exec <service> - 进入容器"
    echo "  build      - 构建镜像"
    echo "  update     - 更新服务"
    echo "  backup     - 备份数据库"
    echo "  restore <file> - 恢复数据库"
    echo "  cleanup    - 清理所有数据"
    echo "  help       - 显示帮助"
    echo ""
    echo "Examples:"
    echo "  $0 start"
    echo "  $0 logs dashboard"
    echo "  $0 exec mysql"
    echo "  $0 backup"
    echo "  $0 restore backup_20230731_120000.sql"
}

# 检查Docker和Docker Compose
check_requirements() {
    if ! command -v docker >/dev/null 2>&1; then
        echo "❌ Docker未安装"
        exit 1
    fi
    
    if ! command -v docker-compose >/dev/null 2>&1; then
        echo "❌ Docker Compose未安装"
        exit 1
    fi
    
    if ! docker info >/dev/null 2>&1; then
        echo "❌ Docker服务未启动"
        exit 1
    fi
}

# 主函数
main() {
    check_requirements
    
    case "$1" in
        "start")
            start_all
            ;;
        "start-base")
            start_base
            ;;
        "start-apps")
            start_apps
            ;;
        "start-full")
            start_full
            ;;
        "stop")
            stop_all
            ;;
        "restart")
            restart
            ;;
        "status")
            show_status
            ;;
        "logs")
            show_logs $2
            ;;
        "exec")
            exec_container $2
            ;;
        "build")
            build_images
            ;;
        "update")
            update
            ;;
        "backup")
            backup_db
            ;;
        "restore")
            restore_db $2
            ;;
        "cleanup")
            cleanup
            ;;
        "help"|"--help"|"-h"|*)
            show_help
            ;;
    esac
}

# 执行主函数
main "$@"
