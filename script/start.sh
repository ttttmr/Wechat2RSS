#!/bin/bash
apt update -y > /dev/null
apt install curl -y > /dev/null
sleep 3s
curl https://wechat2rss.xlab.app/release/server_amd64 -o ./server
chmod +x ./server
cd /wechat2rss
/server
