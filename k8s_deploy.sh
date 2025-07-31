#!/bin/bash

# Kubernetes Deployment Script for Go Gateway
set -e

echo "☸️  Go Gateway Kubernetes Deployment Script"
echo "==========================================="

# 设置变量
NAMESPACE=${KUBE_NAMESPACE:-"go-gateway"}
IMAGE_TAG=${IMAGE_TAG:-"latest"}
REGISTRY=${DOCKER_REGISTRY:-""}

# 函数：检查kubectl
check_kubectl() {
    if ! command -v kubectl >/dev/null 2>&1; then
        echo "❌ kubectl is not installed. Please install kubectl first."
        exit 1
    fi
    
    if ! kubectl cluster-info >/dev/null 2>&1; then
        echo "❌ Cannot connect to Kubernetes cluster. Please check your kubeconfig."
        exit 1
    fi
    
    echo "✅ kubectl is ready"
}

# 函数：创建命名空间
create_namespace() {
    echo "📁 Creating namespace: $NAMESPACE"
    
    if kubectl get namespace $NAMESPACE >/dev/null 2>&1; then
        echo "✅ Namespace $NAMESPACE already exists"
    else
        kubectl create namespace $NAMESPACE
        echo "✅ Namespace $NAMESPACE created"
    fi
}

# 函数：创建ConfigMap
create_configmap() {
    echo "📋 Creating ConfigMap for configuration files..."
    
    # 删除已存在的ConfigMap
    kubectl delete configmap go-gateway-config -n $NAMESPACE 2>/dev/null || true
    
    # 创建新的ConfigMap
    kubectl create configmap go-gateway-config \
        --from-file=conf/prod/ \
        -n $NAMESPACE
    
    echo "✅ ConfigMap created"
}

# 函数：创建Secret（用于证书）
create_secret() {
    echo "🔐 Creating Secret for certificates..."
    
    if [ -d "cert_file" ]; then
        # 删除已存在的Secret
        kubectl delete secret go-gateway-certs -n $NAMESPACE 2>/dev/null || true
        
        # 创建新的Secret
        kubectl create secret generic go-gateway-certs \
            --from-file=cert_file/ \
            -n $NAMESPACE
        
        echo "✅ Secret created"
    else
        echo "⚠️  cert_file directory not found, skipping secret creation"
    fi
}

# 函数：更新镜像标签
update_image_tags() {
    echo "🏷️  Updating image tags to $IMAGE_TAG"
    
    if [ -n "$REGISTRY" ]; then
        sed -i.bak "s|image: go-gateway-dashboard:.*|image: ${REGISTRY}/go-gateway-dashboard:${IMAGE_TAG}|g" k8s_dashboard.yaml
        sed -i.bak "s|image: go-gateway-server:.*|image: ${REGISTRY}/go-gateway-server:${IMAGE_TAG}|g" k8s_server.yaml
    else
        sed -i.bak "s|image: go-gateway-dashboard:.*|image: go-gateway-dashboard:${IMAGE_TAG}|g" k8s_dashboard.yaml
        sed -i.bak "s|image: go-gateway-server:.*|image: go-gateway-server:${IMAGE_TAG}|g" k8s_server.yaml
    fi
    
    echo "✅ Image tags updated"
}

# 函数：部署应用
deploy_app() {
    local component=$1
    local file=$2
    
    echo "🚀 Deploying $component..."
    
    kubectl apply -f $file -n $NAMESPACE
    
    echo "✅ $component deployed"
}

# 函数：等待部署完成
wait_for_deployment() {
    local deployment=$1
    
    echo "⏳ Waiting for $deployment to be ready..."
    
    kubectl wait --for=condition=available --timeout=300s deployment/$deployment -n $NAMESPACE
    
    echo "✅ $deployment is ready"
}

# 函数：显示部署状态
show_status() {
    echo ""
    echo "📊 Deployment Status:"
    echo "===================="
    
    echo ""
    echo "Pods:"
    kubectl get pods -n $NAMESPACE -o wide
    
    echo ""
    echo "Services:"
    kubectl get services -n $NAMESPACE
    
    echo ""
    echo "Ingress:"
    kubectl get ingress -n $NAMESPACE 2>/dev/null || echo "No ingress found"
    
    echo ""
    echo "Deployments:"
    kubectl get deployments -n $NAMESPACE
}

# 函数：显示访问信息
show_access_info() {
    echo ""
    echo "🌐 Access Information:"
    echo "====================="
    
    # 获取NodePort信息
    local dashboard_nodeport=$(kubectl get svc go-gateway-dashboard -n $NAMESPACE -o jsonpath='{.spec.ports[0].nodePort}' 2>/dev/null || echo "N/A")
    local http_nodeport=$(kubectl get svc go-gateway-server-http -n $NAMESPACE -o jsonpath='{.spec.ports[0].nodePort}' 2>/dev/null || echo "N/A")
    local https_nodeport=$(kubectl get svc go-gateway-server-https -n $NAMESPACE -o jsonpath='{.spec.ports[0].nodePort}' 2>/dev/null || echo "N/A")
    local tcp_nodeport=$(kubectl get svc go-gateway-server-tcp -n $NAMESPACE -o jsonpath='{.spec.ports[0].nodePort}' 2>/dev/null || echo "N/A")
    local grpc_nodeport=$(kubectl get svc go-gateway-server-grpc -n $NAMESPACE -o jsonpath='{.spec.ports[0].nodePort}' 2>/dev/null || echo "N/A")
    
    # 获取集群节点IP
    local node_ip=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}' 2>/dev/null)
    if [ -z "$node_ip" ]; then
        node_ip=$(kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' 2>/dev/null)
    fi
    
    echo "Dashboard:"
    echo "  - Internal: http://go-gateway-dashboard.$NAMESPACE.svc.cluster.local:8880"
    if [ "$dashboard_nodeport" != "N/A" ] && [ -n "$node_ip" ]; then
        echo "  - External: http://$node_ip:$dashboard_nodeport"
    fi
    echo "  - Ingress: http://gateway-dashboard.local (if ingress controller is configured)"
    
    echo ""
    echo "Proxy Services:"
    if [ "$http_nodeport" != "N/A" ] && [ -n "$node_ip" ]; then
        echo "  - HTTP:  http://$node_ip:$http_nodeport"
        echo "  - HTTPS: https://$node_ip:$https_nodeport"
        echo "  - TCP:   tcp://$node_ip:$tcp_nodeport"
        echo "  - GRPC:  grpc://$node_ip:$grpc_nodeport"
    fi
    
    echo ""
    echo "Default credentials: admin/123456"
}

# 函数：清理部署
cleanup() {
    echo "🧹 Cleaning up Go Gateway deployment..."
    
    kubectl delete -f k8s_dashboard.yaml -n $NAMESPACE 2>/dev/null || true
    kubectl delete -f k8s_server.yaml -n $NAMESPACE 2>/dev/null || true
    kubectl delete configmap go-gateway-config -n $NAMESPACE 2>/dev/null || true
    kubectl delete secret go-gateway-certs -n $NAMESPACE 2>/dev/null || true
    
    echo "✅ Cleanup completed"
}

# 主函数
main() {
    case "$1" in
        "deploy")
            check_kubectl
            create_namespace
            create_configmap
            create_secret
            update_image_tags
            deploy_app "Dashboard" "k8s_dashboard.yaml"
            deploy_app "Server" "k8s_server.yaml"
            wait_for_deployment "go-gateway-dashboard"
            wait_for_deployment "go-gateway-server"
            show_status
            show_access_info
            ;;
        "status")
            check_kubectl
            show_status
            show_access_info
            ;;
        "cleanup")
            check_kubectl
            cleanup
            ;;
        "logs")
            if [ -z "$2" ]; then
                echo "Usage: $0 logs {dashboard|server}"
                exit 1
            fi
            kubectl logs -f deployment/go-gateway-$2 -n $NAMESPACE
            ;;
        *)
            echo "Usage: $0 {deploy|status|cleanup|logs}"
            echo ""
            echo "Commands:"
            echo "  deploy   - Deploy Go Gateway to Kubernetes"
            echo "  status   - Show deployment status"
            echo "  cleanup  - Remove all Go Gateway resources"
            echo "  logs     - Show logs (dashboard|server)"
            echo ""
            echo "Environment variables:"
            echo "  KUBE_NAMESPACE     - Kubernetes namespace (default: go-gateway)"
            echo "  IMAGE_TAG          - Docker image tag (default: latest)"
            echo "  DOCKER_REGISTRY    - Docker registry prefix"
            echo ""
            echo "Examples:"
            echo "  $0 deploy"
            echo "  IMAGE_TAG=v1.0.0 $0 deploy"
            echo "  DOCKER_REGISTRY=my-registry.com $0 deploy"
            echo "  $0 logs dashboard"
            ;;
    esac
}

# 执行主函数
main "$@"
