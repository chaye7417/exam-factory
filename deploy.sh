#!/bin/bash
# 一键部署脚本：提交 → 推送 → 服务器拉取 → 重启
set -e

SERVER="ubuntu@81.70.28.90"
REMOTE_DIR="/home/ubuntu/exam-factory"

echo "=== 1. 提交本地更改 ==="
git add -A
git commit -m "${1:-update: 部署更新}" || echo "没有新更改需要提交"

echo "=== 2. 推送到 GitHub ==="
git push origin master

echo "=== 3. 服务器拉取并重启 ==="
ssh $SERVER "cd $REMOTE_DIR && git pull origin master && sudo systemctl restart exam-factory"

echo "=== 部署完成 ==="
