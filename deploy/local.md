# 内网部署公网访问

## 内网穿透

全功能对外访问，通过[RSS_TOKEN](./config#rss-token)保护管理功能

TODO 参考Google搜索

## 静态化+Serverless

内网地址仅自己管理订阅，不对外公开

将RSS的xml上传到公网静态服务，图片代理等动态功能通过Serverless实现

通过[RSS_STATIC](./config#rss-static)配置开启静态化，在数据目录中生成`web`文件夹，文件夹内有`feed`文件夹，里面以`xxx.xml`的形式保存RSS

将其上传到静态服务即可，推荐使用定时任务上传

例如将通过Git提交到GitHub，通过GitHub Pages等服务部署

![](/image/local.png)

此时订阅地址应该改为静态服务地址，为了方便在Wechat2RSS服务中管理，需要对应修改[RSS_HOST](./config#rss-host)和[RSS_HTTPS](./config#rss-https)配置

图片代理参考文档[使用Serverless代理](./serverless)
