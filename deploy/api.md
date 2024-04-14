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

如果该公众号已经订阅，此时会立即触发一次更新，所以不要将这个地址作为订阅地址

`k`参数为[RSS_TOKEN](./config#rss-token)配置值

## /feed/:id.xml

RSS订阅地址

默认`:id`为公众号ID

开启[RSS_ENC_FEED_ID](./config#rss-enc-feed-id)后，`id`为`HMAC`计算后的公众号ID，密码由[RSS_SECRET](./config#rss-secret)提供

## /img-proxy?u=http://xx&k=xx

全文输出使用的图片代理

`k`为验证参数，为`u`被`HMAC`计算后的8字符前缀，密码由[RSS_SECRET](./config#rss-secret)提供

## /version

查看当前版本
