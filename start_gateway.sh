#!/bin/bash

# Go Gateway Startup Script
echo "🚀 Go Gateway Startup Script"

PROJECT_DIR="/workspaces/go_gateway"
DEV_CONFIG="./conf/dev/"

start_dashboard() {
    echo "📊 Starting Dashboard..."
    cd $PROJECT_DIR
    go run main.go -endpoint=dashboard -config=$DEV_CONFIG
}

start_server() {
    echo "🔧 Starting Server..."
    cd $PROJECT_DIR
    go run main.go -endpoint=server -config=$DEV_CONFIG
}

show_help() {
    echo "Usage: $0 {dashboard|server|help}"
    echo ""
    echo "Commands:"
    echo "  dashboard  - Start dashboard (admin interface)"
    echo "  server     - Start proxy server"
    echo "  help       - Show this help"
    echo ""
    echo "URLs:"
    echo "  Dashboard: http://localhost:8880"
    echo "  Default login: admin/123456"
}

case "$1" in
    "dashboard")
        start_dashboard
        ;;
    "server")
        start_server
        ;;
    "help"|*)
        show_help
        ;;
esac
