# Go Gateway 环境配置完成

## 📋 安装完成的组件

### 🛢️ 数据库
- ✅ **MySQL 8.0.42** - 端口 3306
  - 数据库：`go_gateway`
  - 用户：`root` 密码：`123456`
  - 连接：`mysql -h 127.0.0.1 -u root -p123456`

- ✅ **Redis 7.0.15** - 端口 6379
  - 连接：`redis-cli`
  - 测试：`redis-cli ping`

### 💾 数据库表结构
已导入完整的数据库结构，包含以下表：
- `gateway_admin` - 管理员表
- `gateway_app` - 应用表  
- `gateway_service_access_control` - 服务访问控制
- `gateway_service_grpc_rule` - GRPC规则
- `gateway_service_http_rule` - HTTP规则
- `gateway_service_info` - 服务信息
- `gateway_service_load_balance` - 负载均衡
- `gateway_service_tcp_rule` - TCP规则

### 🔧 默认管理员账户
- 用户名：`admin`
- 密码：`123456`

## 🚀 启动方式

### 1. 本地开发启动（推荐）

#### 📊 启动管理后台（Dashboard）
```bash
cd /workspaces/go_gateway
./start_gateway.sh dashboard
```
- 访问地址：http://localhost:8880
- 用途：管理服务、查看统计信息、配置代理规则

#### 🔧 启动代理服务器（Server）
```bash
cd /workspaces/go_gateway
./start_gateway.sh server
```
- HTTP代理：http://localhost:8081
- HTTPS代理：https://localhost:8082  
- TCP代理：tcp://localhost:8083
- GRPC代理：grpc://localhost:8084

### 2. Docker容器化启动

#### 🐳 启动所有服务
```bash
cd /workspaces/go_gateway
./docker-manage.sh start
```

#### 🛢️ 仅启动基础服务（数据库）
```bash
./docker-manage.sh start-base
```

#### 📊 启动应用服务
```bash
./docker-manage.sh start-apps
```

#### 🌐 启动完整服务（包括Nginx）
```bash
./docker-manage.sh start-full
```

### 3. Kubernetes集群部署

#### ☸️ 部署到K8s集群
```bash
cd /workspaces/go_gateway
./k8s_deploy.sh deploy
```

#### 📊 查看部署状态
```bash
./k8s_deploy.sh status
```

## 🛠️ 管理脚本

### 数据库管理脚本
```bash
./database_setup.sh [命令]
```

可用命令：
- `start` - 启动MySQL和Redis服务
- `stop` - 停止MySQL和Redis服务
- `restart` - 重启MySQL和Redis服务
- `status` - 检查服务状态
- `test` - 测试数据库连接
- `info` - 显示连接信息
- `createdb` - 创建数据库
- `dbstatus` - 显示数据库状态
- `reset` - 重置数据库（删除所有数据）

### 应用启动脚本
```bash
./start_gateway.sh [命令]
```

可用命令：
- `dashboard` - 启动管理后台
- `server` - 启动代理服务器
- `help` - 显示帮助信息

### Docker管理脚本
```bash
./docker-manage.sh [命令]
```

可用命令：
- `start` - 启动所有服务
- `start-base` - 启动基础服务
- `start-apps` - 启动应用服务
- `start-full` - 启动完整服务（含Nginx）
- `stop` - 停止所有服务
- `restart` - 重启服务
- `status` - 查看状态
- `logs [service]` - 查看日志
- `exec <service>` - 进入容器
- `build` - 构建镜像
- `update` - 更新服务
- `backup` - 备份数据库
- `restore <file>` - 恢复数据库
- `cleanup` - 清理所有数据

### Docker构建脚本
```bash
./docker_build.sh [版本] [--push]
```

示例：
```bash
./docker_build.sh v1.0.0
./docker_build.sh latest --push
```

### Kubernetes部署脚本
```bash
./k8s_deploy.sh [命令]
```

可用命令：
- `deploy` - 部署到集群
- `status` - 查看状态
- `cleanup` - 清理资源
- `logs {dashboard|server}` - 查看日志

## 📁 项目结构

```
go_gateway/
├── main.go                    # 主程序入口
├── database_setup.sh          # 数据库管理脚本
├── start_gateway.sh           # 应用启动脚本
├── docker-manage.sh           # Docker管理脚本
├── docker_build.sh            # Docker构建脚本
├── k8s_deploy.sh             # K8s部署脚本
├── go_gateway.sql            # 数据库结构文件
├── docker-compose.yml        # Docker Compose配置
├── dockerfile-dashboard      # Dashboard Docker文件
├── dockerfile-server         # Server Docker文件
├── nginx.conf               # Nginx配置文件
├── k8s_dashboard.yaml       # K8s Dashboard配置
├── k8s_server.yaml          # K8s Server配置
├── SETUP_COMPLETE.md        # 本文档
├── conf/                    # 配置文件
│   ├── dev/                # 开发环境配置
│   └── prod/               # 生产环境配置
├── controller/             # 控制器
├── dao/                    # 数据访问层
├── dto/                    # 数据传输对象
├── middleware/             # 中间件
├── router/                 # 路由
├── bin/                    # 编译后的二进制文件
├── logs/                   # 日志文件
└── ...
```

## 🔌 API接口

### 管理后台API
- POST `/admin_login/login` - 管理员登录
- GET `/admin_login/logout` - 管理员登出
- GET `/admin/admin_info` - 获取管理员信息
- POST `/admin/change_pwd` - 修改密码

### 服务管理API
- GET `/service/service_list` - 服务列表
- POST `/service/service_add_http` - 添加HTTP服务
- POST `/service/service_add_tcp` - 添加TCP服务  
- POST `/service/service_add_grpc` - 添加GRPC服务

### 应用管理API
- GET `/app/app_list` - 应用列表
- POST `/app/app_add` - 添加应用
- GET `/app/app_stat` - 应用统计

### 仪表板API
- GET `/dashboard/panel_group_data` - 面板数据
- GET `/dashboard/flow_stat` - 流量统计
- GET `/dashboard/service_stat` - 服务统计

## 📚 Swagger文档
访问地址：http://localhost:8880/swagger/index.html

## ⚙️ 配置说明

### 开发环境配置 (conf/dev/)
- `base.toml` - 基础配置（端口、日志等）
- `mysql_map.toml` - MySQL连接配置
- `redis_map.toml` - Redis连接配置
- `proxy.toml` - 代理配置

### 生产环境配置 (conf/prod/)
- 与开发环境结构相同，但配置了生产环境的参数

## 🔍 测试验证

所有组件已测试验证：
- ✅ MySQL数据库连接正常
- ✅ Redis缓存连接正常
- ✅ Go应用编译成功
- ✅ Dashboard启动正常
- ✅ 所有API路由注册成功

## 🎯 下一步操作

1. 启动管理后台：`./start_gateway.sh dashboard`
2. 访问：http://localhost:8880
3. 使用 admin/123456 登录
4. 配置代理服务
5. 启动代理服务器：`./start_gateway.sh server`

## 🆘 故障排除

### 数据库连接问题
```bash
# 检查MySQL状态
sudo service mysql status

# 重启MySQL
sudo service mysql restart

# 测试连接
mysql -h 127.0.0.1 -u root -p123456 -e "SHOW DATABASES;"
```

### Redis连接问题  
```bash
# 检查Redis状态
sudo service redis-server status

# 重启Redis
sudo service redis-server restart

# 测试连接
redis-cli ping
```

### 应用启动问题
```bash
# 检查Go版本
go version

# 检查依赖
go mod tidy

# 重新编译
go build -o bin/gateway main.go
```

---
✅ **环境配置完成！** 现在可以开始使用Go Gateway了。
