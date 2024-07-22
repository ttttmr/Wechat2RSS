# 使用Serverless代理

服务默认提供图片/视频代理，无需配置即可使用，也可独立部署Serverless服务实现

## Cloudflare Worker

在这里[下载脚本](/scripts/cf-worker.js)

填写脚本中第一行的`SECRET`值，例如改为

```js
const SECRET = "abcd1234";
```

修改后，上传部署到Worker中

### 使用`xx.workers.dev`域名

在Wechat2RSS服务中配置环境变量

```shell
RSS_PROXY_SECRET=abcd1234
RSS_PROXY_PREFIX=https://xx.workers.dev
```

> [!TIP]
> docker-compose部署：在`docker-compose.yml`中，添加到`environment`中
> docker部署：添加`-e`参数

### 使用自己的域名

如果想使用自己的域名，例如`rss.example.com`

需要配置Workers路由触发器，可在`Settings - Triggers - Routes`中填写，至少配置路由如下

```shell
rss.example.com/img-proxy/*
rss.example.com/video-proxy/*
rss.example.com/link-proxy/*
```

Wechat2RSS服务环境变量配置参考

```shell
RSS_PROXY_SECRET=abcd1234
RSS_PROXY_PREFIX=https://rss.example.com
```