#!/bin/bash

# Database Setup Script for Ubuntu
# This script provides convenient commands to manage MySQL and Redis

echo "=== Database Management Script ==="
echo ""

# Function to check service status
check_services() {
    echo "🔍 Checking service status..."
    echo "MySQL: $(pgrep mysqld >/dev/null && echo 'Running' || echo 'Stopped')"
    echo "Redis: $(pgrep redis-server >/dev/null && echo 'Running' || echo 'Stopped')"
    echo ""
}

# Function to start services
start_services() {
    echo "🚀 Starting services..."
    sudo service mysql start
    sudo service redis-server start
    echo "✅ Services started"
    echo ""
}

# Function to stop services
stop_services() {
    echo "🛑 Stopping services..."
    sudo service mysql stop
    sudo service redis-server stop
    echo "✅ Services stopped"
    echo ""
}

# Function to restart services
restart_services() {
    echo "🔄 Restarting services..."
    sudo service mysql restart
    sudo service redis-server restart
    echo "✅ Services restarted"
    echo ""
}

# Function to test connections
test_connections() {
    echo "🧪 Testing connections..."
    
    # Test MySQL
    echo -n "MySQL connection: "
    if sudo mysql -u root -e "SELECT 1;" >/dev/null 2>&1; then
        echo "✅ Success"
    else
        echo "❌ Failed"
    fi
    
    # Test Redis
    echo -n "Redis connection: "
    if redis-cli ping | grep -q "PONG"; then
        echo "✅ Success"
    else
        echo "❌ Failed"
    fi
    echo ""
}

# Function to show connection info
show_info() {
    echo "📋 Connection Information:"
    echo "MySQL:"
    echo "  - Host: localhost"
    echo "  - Port: 3306"
    echo "  - User: root (socket authentication)"
    echo "  - Connect: sudo mysql -u root"
    echo ""
    echo "Redis:"
    echo "  - Host: localhost" 
    echo "  - Port: 6379"
    echo "  - Connect: redis-cli"
    echo ""
}

# Function to create Go database
create_go_database() {
    echo "🗄️ Creating database for Go Gateway..."
    sudo mysql -u root -e "CREATE DATABASE IF NOT EXISTS go_gateway CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    
    echo "📥 Importing database schema..."
    if [ -f "go_gateway.sql" ]; then
        sudo mysql -u root go_gateway < go_gateway.sql
        echo "✅ Database schema imported successfully"
    else
        echo "⚠️  go_gateway.sql file not found"
    fi
    
    echo "📊 Database tables:"
    sudo mysql -u root -e "USE go_gateway; SHOW TABLES;"
    echo ""
}

# Function to check database status
check_database() {
    echo "📊 Database Status:"
    echo ""
    
    # Check if database exists
    db_exists=$(sudo mysql -u root -e "SHOW DATABASES LIKE 'go_gateway';" | grep go_gateway)
    if [ -n "$db_exists" ]; then
        echo "✅ Database 'go_gateway' exists"
        
        # Show table count
        table_count=$(sudo mysql -u root -e "USE go_gateway; SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'go_gateway';" | tail -n 1)
        echo "📋 Total tables: $table_count"
        
        # Show admin count
        admin_count=$(sudo mysql -u root -e "USE go_gateway; SELECT COUNT(*) FROM gateway_admin;" | tail -n 1)
        echo "👤 Admin users: $admin_count"
        
        # Show service count  
        service_count=$(sudo mysql -u root -e "USE go_gateway; SELECT COUNT(*) FROM gateway_service_info;" | tail -n 1)
        echo "🔧 Services: $service_count"
    else
        echo "❌ Database 'go_gateway' does not exist"
    fi
    echo ""
}

# Function to reset database
reset_database() {
    echo "🔄 Resetting database..."
    read -p "Are you sure you want to reset the database? This will delete all data! (y/N): " confirm
    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        sudo mysql -u root -e "DROP DATABASE IF EXISTS go_gateway;"
        create_go_database
        echo "✅ Database reset completed"
    else
        echo "❌ Database reset cancelled"
    fi
    echo ""
}

# Main menu
case "$1" in
    "start")
        start_services
        ;;
    "stop") 
        stop_services
        ;;
    "restart")
        restart_services
        ;;
    "status")
        check_services
        ;;
    "test")
        test_connections
        ;;
    "info")
        show_info
        ;;
    "createdb")
        create_go_database
        ;;
    "dbstatus")
        check_database
        ;;
    "reset")
        reset_database
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status|test|info|createdb|dbstatus|reset}"
        echo ""
        echo "Commands:"
        echo "  start    - Start MySQL and Redis services"
        echo "  stop     - Stop MySQL and Redis services"  
        echo "  restart  - Restart MySQL and Redis services"
        echo "  status   - Check service status"
        echo "  test     - Test database connections"
        echo "  info     - Show connection information"
        echo "  createdb - Create Go Gateway database"
        echo "  dbstatus - Show database status and statistics"
        echo "  reset    - Reset database (WARNING: deletes all data)"
        echo ""
        ;;
esac
