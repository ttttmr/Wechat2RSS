#!/bin/sh
set -e

# Docker安装主函数
install_docker() {
    if command -v docker &>/dev/null; then
        echo "✓ Docker已安装"
        return 0
    fi
    echo "✖ Docker未安装，开始安装..."

    # 操作系统检测
    if [ "$(uname -s)" != "Linux" ]; then
        echo "✖ 自动安装Docker仅支持Linux系统" >&2
        exit 1
    fi

    # 统一使用Docker官方脚本安装
    echo "➤ 开始使用Docker官方脚本安装..."
    curl -fsSL "https://get.docker.com" | /bin/sh

    # 验证安装结果
    if ! command -v docker &>/dev/null; then
        echo "✖ Docker安装失败" >&2
        exit 1
    fi
    echo "✓ Docker安装成功"
}

install_wechat2rss() {
    echo "➤ 拉取Docker镜像..."
    if ! docker pull ttttmr/wechat2rss:latest; then
        echo "✖ 镜像拉取失败" >&2
        echo "➤ 重试，或者自行搜索并配置镜像加速" >&2
        exit 1
    fi

    echo "➤ 请输入部署目录(默认:/wechatrss): "
    read -r deploy_path
    deploy_path=${deploy_path:-/wechatrss}
    
    echo "➤ 创建目录..."
    if ! mkdir -p "$deploy_path" 2>/dev/null; then
        echo "✖ 目录创建失败，请检查权限" >&2
        exit 1
    fi

    echo "➤ 创建数据目录..."
    if ! mkdir -p "${deploy_path}/data" 2>/dev/null; then
        echo "✖ 数据目录创建失败，请检查权限" >&2
        exit 1
    fi

    # 加载现有配置
    if [ -f "$deploy_path/wechat2rss.env" ]; then
        echo "➤ 检测到已有配置文件，加载默认值..."
        . "$deploy_path/wechat2rss.env"
        
        # 解析RSS_HOST为IP和端口
        if [ -n "$RSS_HOST" ]; then
            RSS_IP="${RSS_HOST%:*}"
            RSS_PORT="${RSS_HOST#*:}"
        fi
    fi

    # 交互式配置
    echo "➤ 配置激活信息"
    read -p "邮箱${LIC_EMAIL:+ (默认: $LIC_EMAIL)}: " input
    LIC_EMAIL="${input:-$LIC_EMAIL}"
    read -p "激活码${LIC_CODE:+ (默认: $LIC_CODE)}: " input
    LIC_CODE="${input:-$LIC_CODE}"

    echo "➤ 配置部署信息"
    # 尝试获取外网IP作为默认值
    echo "➤ 正在获取服务器外网IP..."
    PUBLIC_IP=$(curl -s ifconfig.me || curl -s icanhazip.com || echo "")
    
    if [ -n "$PUBLIC_IP" ]; then
        echo "✓ 成功获取外网IP: $PUBLIC_IP"
    else
        echo "✖ 获取外网IP失败"
    fi
    
    read -p "服务器IP地址或域名${RSS_IP:+ (默认: $RSS_IP)}${PUBLIC_IP:+${RSS_IP:+, }(公网IP: $PUBLIC_IP)}: " input
    RSS_IP="${input:-${RSS_IP:-${PUBLIC_IP:+$PUBLIC_IP}}}"
    read -p "端口号 (默认: ${RSS_PORT:-8080}): " input
    RSS_PORT="${input:-${RSS_PORT:-8080}}"
    RSS_HOST="$RSS_IP:$RSS_PORT"

    echo "➤ 写入docker-compose配置文件..."
    cat > "$deploy_path/docker-compose.yml" << EOF
services:
  wechat2rss:
    container_name: wechat2rss
    image: "ttttmr/wechat2rss:latest"
    env_file: "wechat2rss.env"
    volumes:
      - "${deploy_path}/data:/wechat2rss" # 数据持久化保存
    ports:
      - "${RSS_PORT}:8080" # 动态端口配置
    deploy: # 自动重启策略
      restart_policy:
        condition: on-failure
        max_attempts: 3
        window: 10s
    logging:
      driver: "json-file"
      options:
        max-size: "100m"
EOF

    if [ ! -s "$deploy_path/docker-compose.yml" ]; then
        echo "✖ 配置文件写入失败" >&2
        exit 1
    fi

    # 写入.env文件
    echo "LIC_EMAIL=$LIC_EMAIL" > "$deploy_path/wechat2rss.env"
    echo "LIC_CODE=$LIC_CODE" >> "$deploy_path/wechat2rss.env"
    echo "RSS_HOST=$RSS_HOST" >> "$deploy_path/wechat2rss.env"

    # 启动容器
    echo "➤ 启动容器..."
    if ! docker compose -f "$deploy_path/docker-compose.yml" up -d; then
        echo "✖ 启动容器失败" >&2
        exit 1
    fi
    # 等待10秒
    sleep 10
    echo "✓ 容器启动成功"
    
    # 显示容器日志
    echo "➤ 显示容器日志..."
    if ! docker logs wechat2rss --tail 20; then
        echo "✖ 获取容器日志失败" >&2
    fi
    
    # 提取关键信息
    echo "\n✓ 关键配置信息："
    docker logs wechat2rss --tail 20 2>&1 | grep -oE '(Addr: |Token: ).+' | while read -r line; do
        echo "➤ $line"
    done
}

# 主执行流程
install_docker
install_wechat2rss