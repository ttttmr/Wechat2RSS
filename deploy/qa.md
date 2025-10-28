# 常见问题 Q&A

Bug反馈：在[GitHub中提Issue](https://github.com/ttttmr/Wechat2RSS/issues)，选择`Bug反馈`

问题咨询：在[Discussions中提问](https://github.com/ttttmr/Wechat2RSS/discussions/categories/q-a)

## 服务可用性

公开服务和私有部署软件一致，可以通过观测公开服务更新情况判断

以下是一些经常更新的公众号

- [中国政府网](https://wechat2rss.xlab.app/feed/dbd2adffac6759c353702555dea8716dff75c4be.xml)
- [猫笔刀](https://wechat2rss.xlab.app/feed/33d986064f59be5263de2ca822fb3e0bdd59eb81.xml)

## 微信风控相关

### 被微信风控如何操作

参考[手动解除风控](./guide#手动解除风控)

### 被风控后，不做任何操作，会自动解封吗？

会，但时间无法估计，目前重试只是检查是否解封，等待时间是为了减小频率避免再次被封

### 风控后等待时间说明

目前设计每次触发微信限制，都会将等待时间乘以2

初次等待15分钟，15分钟后发现仍然未解封，将等待30分钟，以此类推60分钟，120分钟...，最大等待时间为6小时

当发现已经解封时，将会重置下次等待时间为15分钟

## 服务部署

### 如何查看日志

查看最新100条日志

docker部署使用这个命令查看

```shell
docker logs wechat2rss -n 100
```

如果是docker compose部署

```shell
docker compose logs -n 100
```

其他部署方式请在[部署指南](./deploy)中查看

### 服务迁移

如更换VPS部署，复制数据目录，保持相同的文件目录结构后直接启动即可

例如现有服务部署目录结构如下

```
/data/wechat2rss
  - docker-compose.yml
  - data
    - res.db
```

关闭现有服务

```
docker compose down
```

复制整个`wechat2rss`目录到新服务器上

在新的目录执行`docker compose up -d`即可

## 订阅和使用

### 为什么公众号没有更新？

根据[更新频率策略设计](https://blog.xlab.app/p/d73537b/)，每个公众号每天会检查更新1-2次，更新延迟在0-24小时内波动

如果公众号在24小时前发布了文章，但RSS中没有这篇文章，可能是因为以下两种情况

#### 1. 文章不是群发消息

目前RSS只能收录群发消息

公众号在发表文章时，可选开启群发，每个公众号每天只能群发一次

- 群发=会在**订阅号消息**列表中展示
- 非群发=只能进入公众号主页中展示

详细参考[公众号的群发和发布？](https://developers.weixin.qq.com/community/develop/article/doc/00000a2fb906c0b93150ee62366013)

至于如何区分是不是群发，可以看下阅读量，群发消息阅读量会比较高，非群发消息则比较低

#### 2. 微信账号正在风控中

期间会推迟刷新，解封后自动恢复，详见[账号管理和风控](./guide#账号管理)

### 添加订阅后显示为数字而不是名字

新增订阅默认为数字，在爬取完数据后会展示为名字

如果长时间都显示为数字，可能是因为账号被风控爬数据失败，解除风控查看[这里](./guide#手动解除风控)

### 历史文章说明

程序逻辑：抓取->存储->输出

程序只抓取最新20篇，不抓取历史文章

存储数量受[RSS_KEEP_OLD_COUNT](./config#RSS_KEEP_OLD_COUNT)配置限制

RSS输出数量受[RSS_MAX_ITEM_COUNT](./config#RSS_KEEP_NEW_COUNT)配置限制