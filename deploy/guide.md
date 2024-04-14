# 使用指南

## 部署安装与升级

推荐使用Docker/Docker Compose部署，推荐2G内存以上配置

Docker镜像为`ttttmr/wechat2rss`

> [!TIP]
> 一键安装Docker和Docker Compose
> `curl -fsSL "https://get.docker.com" | /bin/sh`

### Docker部署

Docker命令参考

```shell
docker run -d \
  --name wechat2rss \
  -v ./data:/wechat2rss \
  -p 8080:8080 \
  -e LIC_EMAIL="i@xlab.app" \
  -e LIC_CODE="f2aa6823-b2a6-4670-9acd-0e26d1204a43" \
  -e RSS_HTTPS=0 \
  -e RSS_HOST="192.168.123.123:8080" \
  ttttmr/wechat2rss:latest
```

> [!IMPORTANT]
> 务必将`/wechat2rss`目录进行持久化保存，并妥善保管持久化之后的目录文件如`./data`
> 后续升级或迁移服务等操作，请注意依然将此文件夹映射为容器中的`/wechat2rss`目录

`-e`参数可以添加更多环境变量

> [!TIP]
> 完整配置和说明见[参数配置](config)

#### 升级

删除旧容器

```shell
docker stop wechat2rss
docker rm wechat2rss
```

拉取最新镜像

```shell
docker pull ttttmr/wechat2rss:latest
```

然后重新执行安装步骤

### Docker Compose 部署

下载`docker-compose.yml`

```shell
wget https://wechat2rss.xlab.app/docker-compose.yml
```

修改配置，填写`LIC_EMAIL`、`LIC_CODE`和`RSS_HOST`等配置到环境变量中

```shell
vi docker-compose.yml
```

> [!TIP]
> 完整配置和说明见[参数配置](config)

启动服务

```shell
docker compose up -d
```

#### 升级

```shell
docker compose pull
docker compose up -d
```

## 登录和使用

### 微信登录

服务通过读书获取公众号信息，如果未试用过，需要先安装使用授权

> [!NOTE] 微信读书获取公众号授权
> 在微信中打开任意一篇公众号文章，点击分享，选择`在微信读书中阅读`，完成微信读书授权

访问`/login`，微信扫码登录

如果手机端提示异地登陆验证，请在网页中填写提交

> [!TIP]
> 完成扫码并成功登录后，若需退出当前账号或重新登录，请先在微信阅读App的设备管理删除本设备

### 添加订阅

#### 微信公众号ID订阅

浏览器打开公众号文章，`f12`打开控制台，输入以下代码获得一串数字

```js
atob(biz)
```

访问`/add/公众号ID`，添加成功后自动跳转到订阅链接(公众号ID请忽略引号)

## 服务管理

### 权限管理

配置[RSS_TOKEN](./config#rss-token)对添加订阅进行鉴权

配置[RSS_ENC_FEED_ID](./config#rss-enc-feed-id)，对订阅地址进行加密

### 配置服务异常告警

配置[BOT_TG_TOKEN](./config#bot-tg-token)启用Telegram Bot

配置[BOT_SERVER_KEY](./config#bot-server-key)启用[Server酱](https://sct.ftqq.com/)
