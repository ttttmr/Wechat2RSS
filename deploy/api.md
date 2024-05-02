# API参考

为注明均为`GET`请求

## /login

二维码登录页面，获得登录会话

## /login/check

在登录会话中检查登录状态

## /login/code

在登录会话中`POST`提交验证码

## /add/:id?k=xxx

根据公众号ID添加订阅，添加成功后自动跳转到订阅地址，`:id`为公众号ID

添加成功后会提交一个更新任务，获取文章内容，一般在1-3秒内完成，如果触发微信风控，任务会被推迟一定时间后自动重试，详见[Q&A 频率限制问题](./qa#频率限制问题)

如果该公众号已经订阅，同样也会触发更新任务，所以不要将这个地址作为订阅地址，避免频繁触发更新

`k`参数为[RSS_TOKEN](./config#rss-token)配置值，如果未设置，则不需要该参数

## /addurl?url=<https://xxx>&k=xxx

同`/add`接口，自动解析文章中的公众号ID

`k`参数为[RSS_TOKEN](./config#rss-token)配置值，如果未设置，则不需要该参数

## /del/:id?k=xxx

根据公众号ID删除订阅

`k`参数为[RSS_TOKEN](./config#rss-token)配置值，如果未设置，则不需要该参数

## /list?k=xxx

列出所有订阅的公众号

`k`参数为[RSS_TOKEN](./config#rss-token)配置值，如果未设置，则不需要该参数

返回数据为如下JSON格式数据：

```json
{
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

## /feed/:id.xml

RSS订阅地址

默认`:id`为公众号ID

开启[RSS_ENC_FEED_ID](./config#rss-enc-feed-id)后，`id`为`HMAC`计算后的公众号ID，密码由[RSS_SECRET](./config#rss-secret)提供

## /refresh

清除等待时间，立即刷新内容

关于等待时间可以看[Q&A 频率限制问题](./qa#频率限制问题)

## /img-proxy?u=http://xx&k=xx

全文输出使用的图片代理

`k`为验证参数，为`u`被`HMAC`计算后的8字符前缀，密码由[RSS_SECRET](./config#rss-secret)提供

## /version

查看当前版本
