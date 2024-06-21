# 使用指南

软件以Docker镜像的形式发布，Docker镜像为`ttttmr/wechat2rss`，有`amd64`和`arm64`两个版本，支持Apple Silicon

## 部署安装与升级

如果你有服务器/电脑，推荐使用Docker Compose部署，推荐1G内存以上配置

如果你没有服务器，也不熟悉Docker，可以[一键部署到Railway](#railway部署)

## Docker Compose 部署（推荐）

> [!TIP]
> 一键安装Docker和Docker Compose
> `curl -fsSL "https://get.docker.com" | /bin/sh`

下载`docker-compose.yml`

```shell
wget https://wechat2rss.xlab.app/docker-compose.yml
```

修改配置文件，填写`LIC_EMAIL`、`LIC_CODE`和`RSS_HOST`等配置到环境变量中

```shell
vi docker-compose.yml
```

> [!TIP]
> 完整配置和说明见[参数配置](config)

启动服务

```shell
docker compose up -d
```

### 升级

```shell
docker compose pull
docker compose up -d
```

## Docker部署

Docker命令参考

```shell
docker run -d \
  --name wechat2rss \
  -v ./data:/wechat2rss \ # 数据保存目录，./data可以改成其他目录
  -p 8080:8080 \ # 端口映射，可以改为9090:8080
  -e LIC_EMAIL=i@xlab.app \ # 授权邮箱
  -e LIC_CODE=f2aa6823-b2a6-4670-9acd-0e26d1204a43 \ # 激活码
  -e RSS_HOST=192.168.123.123:8080 \ # 服务器地址
  ttttmr/wechat2rss:latest
```

> [!IMPORTANT] 数据保存提示
> 务必将容器`/wechat2rss`目录进行持久化保存，并妥善保管持久化之后的目录文件如`./data`
> 后续升级或迁移服务等操作，请注意依然将此文件夹映射为容器中的`/wechat2rss`目录

填写`LIC_EMAIL`、`LIC_CODE`和`RSS_HOST`等配置到环境变量中

> [!TIP]
> `-e`参数可以添加更多环境变量
> 完整配置和说明见[参数配置](config)

### 升级

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

## Railway部署

点击一键部署，包含自动升级更新

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/KIQWgJ?referralCode=t4q678)

配置页填入`LIC_EMAIL`为邮箱，`LIC_CODE`为激活码

> [!TIP]
> 完整配置和说明见[参数配置](config)

一段时间部署完成后，rss服务会自动分配一个`xxx.railway.app`的域名，打开就可以使用了

打开后在服务配置页，填写RSS_TOKEN用于服务认证，确保只有知道这个TOKEN的人才能使用（相当于密码）

> [!TIP] Railway计费说明
> https://railway.app/pricing

## 登录和使用

### 微信登录

服务通过读书获取公众号信息，如果未试用过，需要先安装使用授权

> [!NOTE] 微信读书获取公众号授权
> 在微信中打开任意一篇公众号文章，点击分享，选择`在微信读书中阅读`，完成微信读书授权

首页点击`账号登录`跳转登录页面，微信扫码登录

如果手机端提示异地登陆验证，请在网页中填写提交

> [!TIP]
> 完成扫码并成功登录后，若需退出当前账号或重新登录，请先在微信阅读App的设备管理删除本设备

### 添加订阅

`RSS_TOKEN`处填写配置的值，如果没有配置，则不需要填写

#### 微信公众号文章链接订阅

填入公众号文章链接后，点击订阅

订阅成功后下方会显示订阅地址

#### 微信公众号ID订阅

浏览器打开公众号文章，`f12`打开控制台，输入以下代码获得一串数字，即公众号ID

```js
atob(biz)
```

### 删除订阅

点击订阅管理列表中的`刷新列表`，可以列出当前订阅的所有公众号

点击后面的删除按钮即可删除订阅

## 服务管理

### 权限管理

配置[RSS_TOKEN](./config#rss-token)对订阅管理进行鉴权

配置[RSS_ENC_FEED_ID](./config#rss-enc-feed-id)，对订阅地址进行加密

### 配置服务异常告警

配置[BOT_TG_TOKEN](./config#bot-tg-token)启用Telegram Bot

配置[BOT_SERVER_KEY](./config#bot-server-key)启用[Server酱](https://sct.ftqq.com/)
