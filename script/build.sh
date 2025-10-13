#!/bin/bash
apt update -y
apt install curl -y
curl https://wechat2rss.xlab.app/release/server_amd64 -o /server
chmod +x /server
