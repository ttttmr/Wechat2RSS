#!/bin/bash
sleep 3s
curl https://wechat2rss.xlab.app/release/server_amd64 -o ./server
chmod +x ./server
cd /wechat2rss
/server
