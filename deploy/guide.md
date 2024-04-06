# 使用指南

## Docker部署

推荐2G内存以上配置，安装`Docker`和`Docker Compose`

在[这里](https://github.com/ttttmr/Wechat2RSS/releases)下载最新安装包并解压

包含以下文件：

```bash
wechat2rss-server
Dockerfile
docker-compose.yml
```

创建`.env`文件进行配置，内容参考如下：

```shell
LIC_EMAIL="i@xlab.app" # 邮箱
LIC_CODE="f2aa6823-b2a6-4670-9acd-0e26d1204a43" # 激活码

RSS_HTTPS=0 # 是否启用HTTPS，0为不启用，1为启用
RSS_HOST="192.168.123.123:8080" # RSS服务的域名和端口
```

> [!TIP]
> 完成配置和说明见[参数配置](config)

默认服务监听`8080`端口，可在`docker-compose.yml`中修改

下载镜像并启动服务

```bash
docker compose up -d --build
```

服务数据会保存到当前目录的`data`文件夹中

## 微信登陆

服务通过读书获取公众号信息，如果未试用过，需要先安装使用授权

> [!NOTE] 微信读书获取公众号授权
> 在微信中打开任意一篇公众号文章，点击分享，选择`在微信读书中阅读`，完成微信读书授权

访问`/login`，微信扫码登陆

## 添加订阅

### 微信公众号ID订阅

浏览器打开公众号文章，`f12`打开控制台，输入以下代码获得一串数字

```js
atob(biz)
```

访问`/add/公众号ID`获得订阅链接

## 服务管理

### 权限管理

配置[RSS_TOKEN](./config#rss-token)对添加订阅进行鉴权

配置[RSS_ENC_FEED_ID](./config#rss-enc-feed-id)，对订阅地址进行加密

### 配置消息通知

配置[BOT_TG_TOKEN](./config#bot-tg-token)启用Telegram Bot

配置[BOT_SERVER_KEY](./config#bot-server-key)启用[Server酱](https://sct.ftqq.com/)
