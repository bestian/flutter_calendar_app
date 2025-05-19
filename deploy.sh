#!/bin/bash
# 部署 Flutter Web 到 GitHub Pages 的自動化腳本
# 使用前請確保已經設定好 gh-pages branch 並有 git push 權限
# 適用於 repo 根目錄運行

set -e

REPO_NAME="$(basename `git rev-parse --show-toplevel`)"
BASE_HREF="/$REPO_NAME/"

# 1. Build flutter web，指定正確 base-href
flutter build web --base-href "$BASE_HREF"

# 2. 將 build/web 推送到 gh-pages 分支
cd build/web

git init

git remote add origin $(git -C ../.. remote get-url origin)
git checkout -b gh-pages

git add .
git commit -m "deploy to gh-pages"
git push --force origin gh-pages

cd ../..

echo "\n部署完成！請到 GitHub Pages 設定 gh-pages 分支為發佈來源。\n網址：https://<你的帳號>.github.io/$REPO_NAME/"
