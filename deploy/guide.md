# 使用指南

软件以Docker镜像的形式发布，Docker镜像为`ttttmr/wechat2rss`，有`amd64`和`arm64`两个版本，支持Apple Silicon

## 部署安装与升级

如果你有服务器/电脑，推荐使用Docker Compose部署，推荐1G内存以上配置

如果你没有服务器，也不熟悉Docker，可以试试

[一键部署到Railway](#railway部署)

[一键部署到Sealos](#sealos部署)

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

部署完成，继续[登录和使用](#登录和使用)

### 升级

```shell
docker compose pull
docker compose up -d
```

## Railway部署

点击一键部署，包含自动升级更新

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/KIQWgJ?referralCode=t4q678)

配置页填入`LIC_EMAIL`为邮箱，`LIC_CODE`为激活码

> [!TIP]
> 完整配置和说明见[参数配置](config)

一段时间部署完成后，rss服务会自动分配一个`xxx.railway.app`的域名，打开就可以使用了

默认配置RSS_TOKEN为注册的邮箱，需要在页面中填写，否则会提示`token is wrong`

> [!TIP] Railway计费说明
> https://railway.app/pricing

部署完成，继续[登录和使用](#登录和使用)

## Sealos部署

目前应用还[未被收录](https://github.com/labring-actions/templates/pull/326)，目前需要手动复制模板部署

### 注册并登录 Sealos

注册地址 https://cloud.sealos.run/?uid=Gkr1H6rWou

可以用任意区域，国内国外都可以，但注意价格不同

### 打开模板编辑器

在主页中找到`应用商店`，点击左下角`我的应用`，再点击右上角`在线调试模板`，进入编辑器页面

### 填写YAML模板

模板地址 https://github.com/ttttmr/templates/blob/main/template/wechat2rss.yaml

复制链接中的内容，粘贴到左侧YAML代码区

### 填写邮箱和激活码等配置

粘贴YAML完稍等片刻，右侧出现表单，填写邮箱和激活码等配置

### 部署启动

点击`试运行部署`，成功后会出现`正式部署`，点击`正式部署`

再回到主页中，找到`应用管理`，点击`详情`就能看到Sealos提供的公网地址了

### 计费说明

目前模板配置是0.5核，512M内存，1G存储

测试最低0.2核，加载登录二维码有时会卡，其他应该还好

以目前最便宜的北京A区为例，粗略计算

- 存储+端口基础费用 5/月
- 0.5核=6/月 0.2=2.5/月
- 512M 3/月

网络费用另算，基础开销在11-15元/月

## 登录和使用

### 微信登录

服务通过读书获取公众号信息，如果未试用过，需要先安装使用授权

> [!NOTE] 微信读书获取公众号授权
> 在微信中打开任意一篇公众号文章，点击分享，选择`在微信读书中阅读`，完成微信读书授权

首页点击`账号登录`跳转登录页面，微信扫码登录

如果手机端提示异地登陆验证，请在网页中填写提交

### 添加订阅

`RSS_TOKEN`处填写配置的值，如果没有配置，则不需要填写

#### 文章链接订阅

填入公众号文章链接后，点击订阅

订阅成功后下方会显示订阅地址

#### 公众号ID订阅

浏览器打开公众号文章，`f12`打开控制台，输入以下代码获得一串数字，即公众号ID

```js
atob(biz)
```

### 删除订阅

点击订阅管理列表中的`刷新列表`，可以列出当前订阅的所有公众号

点击后面的删除按钮即可删除订阅

## 服务管理

可以在`服务配置`页，配置以下功能

### 权限管理

配置[RSS_TOKEN](./config#rss-token)对订阅管理进行鉴权

配置[RSS_ENC_FEED_ID](./config#rss-enc-feed-id)，对订阅地址进行加密

### 配置服务异常告警

当服务遇到被微信风控/账号推出登录灯异常情况，会发送告警信息，支持以下渠道

配置[BOT_TG_TOKEN](./config#bot-tg-token)，使用Telegram Bot告警

配置[BOT_SERVER_KEY](./config#bot-server-key)，使用[Server酱](https://sct.ftqq.com/)告警

配置[BOT_WEBHOOK_URL](./config#bot-server-key)，使用Webhook告警

配置[BOT_BARK_URL](./config#bot-server-key)，使用[Bark](https://bark.day.app/)告警