# 常见问题 Q&A

遇到问题可在[GitHub中提Issue](https://github.com/ttttmr/Wechat2RSS/issues)

用户Telegram群组：[邀请链接](https://t.me/+8COw6-luUoVlZGVh)

## 如何查看日志

查看最新100条日志

```shell
docker logs wechat2rss -n 100
```

## 频率限制问题

日志中体现为`被微信限频...`，如果配置了消息通知，收到消息通知为`需要验证`

解除限制问题需要进行以下操作

1. 在微信读书中的书架页打开`文章收藏`
2. 如有授权提示，需要根据提示进行授权
3. 如果没有，在收藏列表中点击任意一个公众号名称，进入公众号文章列表页，根据提示进行操作

> [!TIP]
> 如果此前未使用过微信阅读查看公众号文章将不会在微信阅读app的书架页看到`文章收藏`
> 请在微信中打开一篇公众号文章后点击右上角--在微信阅读中打开，操作后即可显示书架页的`文章收藏`

## 如何订阅版本发布？

目前会更新[发布记录](./changelog.md)，所以可以用RSSHub订阅这个文件的修改

[版本发布RSS](https://rsshub.app/github/file/ttttmr/Wechat2RSS/master/deploy/changelog.md)
