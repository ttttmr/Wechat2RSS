# API参考

未注明均为`GET`请求

API通过url中的k参数进行鉴权，`k`参数为[RSS_TOKEN](./config#rss-token)配置值

## /login/new

> [!TIP] 需要鉴权

添加新的的微信账号

响应中包含cookie，携带cookie请求此接口可以查询后续更新情况

```json
{
    "err": "",
    "data": {
        "isLogin": true,
        // data:image/png;base64,格式的二维码图片数据
        "qrcode": ""
    }
}
```

## /login/code

> [!TIP] 需要鉴权

携带cookie，`POST`提交验证码，响应如下

```json
{
    "err": "",
}
```

## /login/list

> [!TIP] 需要鉴权

列出所有微信账号，响应如下

```json
{
    "err": "",
    "data": [
        {
            "id": 12345, // 账号id
            "name": "xxx", // 账号昵称
            "available": true, // 登录是否正常
            "errCount": 0, // 当前风控次数
            "waitTime": "2024-11-10 21:46:45" // 下次检查风控状态时间
        }
        ...
    ]
}
```

## /login/refresh/:id

> [!TIP] 需要鉴权

刷新风控信息，标记账号已解除风控

解除风控可以看[Q&A 频率限制问题](./qa#频率限制-微信风控问题)

## /login/del/:id

> [!TIP] 需要鉴权

删除账号

## /add/:id

> [!TIP] 需要鉴权

根据公众号ID添加订阅，`:id`为公众号ID，响应如下

```json
{
    "err": "",
    "data": "http://xxx" // 订阅地址
}
```

添加成功后会提交一个更新任务，获取文章内容，一般在1-3秒内完成，如果触发微信风控，任务会被推迟一定时间后自动重试，详见[Q&A 频率限制问题](./qa#频率限制问题)

如果该公众号已经订阅，同样也会触发更新任务，所以不要将这个地址作为订阅地址，避免频繁触发更新

## /addurl?url=<https://xxx>

> [!TIP] 需要鉴权

同`/add`接口，自动解析文章中的公众号ID

## /del/:id

> [!TIP] 需要鉴权

根据公众号ID删除订阅

## /list

> [!TIP] 需要鉴权

列出所有订阅的公众号

返回数据为如下JSON格式数据：

```json
{
    "err": "",
    "data": [
        {
            "id": 12345,  // 公众号ID
            "name": "XX号", // 公众号名字
            "link": "http://xxx", // 订阅地址
        },
        {
            "id": 12345,
            "name": "XX号",
            "link": "http://xxx",
        }
        ...
    ]
}
```

## /opml

> [!TIP] 需要鉴权

导出opml订阅源的下载链接

## /config

> [!TIP] 需要鉴权

`GET`获取配置信息，响应如下

```json
{
    "err": "",
    "data": {
        "host": "http://xxx",
        ...
    }
}
```

`POST`提交配置信息，请求数据格式为上述`data`数据结构

其中`token`，`secret`，`proxy_secret`字段，`GET`请求时响应的值为空，`POST`提交时为空则视为不修改

> [!WARNING]
> 此处修改配置如果和已配置的环境遍历冲突，服务重启后，会恢复为环境变量配置，建议删除环境变量

## /feed/:id.(xml/json)

RSS订阅地址，支持RSS和JSON Feed两种格式，通过后缀名控制，默认为xml

默认`:id`为公众号ID

开启[RSS_ENC_FEED_ID](./config#rss-enc-feed-id)后，`id`为`HMAC`计算后的公众号ID，密码由[RSS_SECRET](./config#rss-secret)提供

## /feed/all.(xml/json)?k=xxx

> [!TIP] 需要鉴权

合集RSS订阅地址，支持RSS和JSON Feed两种格式，通过后缀名控制，默认为xml

此接口开启[RSS_STATIC](./config#rss-static)时无效

## /img-proxy?u=<http://xx&k=xx>

全文输出使用的图片代理

`k`为验证参数，为`u`被`HMAC`计算后的8字符前缀，密码由[RSS_PROXY_SECRET](./config#rss-proxy-secret)提供

## /video-proxy?u=<http://xx&k=xx>

全文输出使用的图片代理

`k`为验证参数，为`u`被`HMAC`计算后的8字符前缀，密码由[RSS_PROXY_SECRET](./config#rss-proxy-secret)提供

## /link-proxy?<http://xx&k=xx>

跳转微信打开

`k`为验证参数，为`u`被`HMAC`计算后的8字符前缀，密码由[RSS_PROXY_SECRET](./config#rss-proxy-secret)提供

## /version

查看当前版本
