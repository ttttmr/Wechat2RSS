# 参数配置

服务通过环境变量进行配置，也可通过服务配置页进行配置

优先级：环境变量 > 已存储的配置 = 服务配置页提交配置

服务启动时会将环境变量配置**覆盖导入**数据库中，` 第一次启动必填项`配置在后续部署启动时可以删除

## LIC_EMAIL

> [!IMPORTANT] 第一次启动必填项

```shell
LIC_EMAIL=i@xlab.app
```

授权邮箱

## LIC_CODE

> [!IMPORTANT] 第一次启动必填项

```shell
LIC_CODE=f2aa6823-b2a6-4670-9acd-0e26d1204a43
```

授权激活码

## RSS_HOST

> [!IMPORTANT] 第一次启动必填项

```shell
RSS_HOST=192.168.1.1:8080
```

生成的RSS的地址，需包含端口号

此配置仅控制生成内容中的链接地址，不会影响实际访问后台的地址

## RSS_HTTPS

```shell
RSS_HTTPS=0
```

控制生成的RSS内容中本站链接是否为`https`，如RSS的`link地址`和`图片代理地址`

`0`为不使用，`1`为使用，默认为`0`

此配置仅控制生成内容中的链接地址，不会影响实际访问后台的协议

## RSS_TOKEN

```shell
RSS_TOKEN=password123
```

对添加/删除/列出订阅等动作进行保护，需要增加`k`参数访问

```shell
/add/12345?k=password123
/del/12345?k=password123
```

详细API地址参见[API参考](./api)

## RSS_ENC_FEED_ID

```shell
RSS_ENC_FEED_ID=0
```

生成的RSS地址进行加密，`0`为不使用，`1`为使用

例如微信公众号ID为`123456`，添加订阅此时订阅链接为`/feed/123456.xml`

开启后订阅地址会被加密`/feed/f2fd5af8dc3590b99509f0c501de01066d063028.xml`

> [!TIP] 推荐第一次部署就设置好
> 后续开启/关闭时，只有`新订阅`/`旧订阅触发更新`时才会修改订阅地址

## RSS_SECRET

```shell
RSS_SECRET=abcdef123
```

用于加密的密钥，可不填，会自动随机生成

## RSS_STATIC

```shell
RSS_STATIC=0
```

对RSS订阅内容静态化，`0`为不使用，`1`为使用

开启后会将RSS文件保存到数据目录中`web/feed`目录中

同时`/feed/*.xml`由此目录静态文件提供

> [!TIP] 推荐第一次部署就设置好
> 后续开启时，只有`新订阅`/`旧订阅触发更新`时才会生成xml文件

## RSS_MAX_ITEM_COUNT

```shell
RSS_MAX_ITEM_COUNT=20
```

控制RSS最大输出文章数量，默认为20

## RSS_PROXY_SECRET

```shell
RSS_PROXY_SECRET=abcd1234
```

用于加密的密钥，不填时自动随机生成

部署Serverless时建议手动填写

## RSS_PROXY_PREFIX

```shell
RSS_PROXY_PREFIX=https://wechat2rss.xlab.app
```

默认通过`RSS_HTTPS`和`RSS_HOST`配置自动生成

部署Serverless时如果使用的域名不同需要手动填写

## BOT_TG_TOKEN

> [!IMPORTANT]
> `BOT_TG_TOKEN`和`BOT_TG_ADMIN_UID`需要同时填写

```shell
BOT_TG_TOKEN=123:abcd
```

通过Telegram Bot推送服务消息，填写`Bot Token`

## BOT_TG_ADMIN_UID

> [!IMPORTANT]
> `BOT_TG_TOKEN`和`BOT_TG_ADMIN_UID`需要同时填写

```shell
BOT_TG_ADMIN_UID=12345
```

通过Telegram Bot推送服务消息到指定用户

> [!TIP]
> 给[@userinfobot](https://t.me/userinfobot)发消息获得自己的ID

## BOT_SERVER_KEY

```shell
BOT_SERVER_KEY=SCT123456
```

通过[Server酱](https://sct.ftqq.com/)推送服务消息

## BOT_WEBHOOK_URL

```shell
BOT_WEBHOOK_URL=https://xxx.com/webhook/xx
```

通过Webhook推送服务消息，填写`Webhook URL`

将以`POST`请求发送JSON数据，格式如下

```json
{
    "msg_type": "text", // 固定值
    "content": {
        "text": "hello" // 消息内容
    }
}
```
