#!/bin/bash
# 部署 Flutter Web 到 GitHub Pages 的自動化腳本
# 使用前請確保已經設定好 gh-pages branch 並有 git push 權限
# 適用於 repo 根目錄運行

set -e

# REPO_NAME="$(basename `git rev-parse --show-toplevel`)"
# BASE_HREF="/$REPO_NAME/"

# 1. Build flutter web，指定正確 base-href
flutter build web   # --base-href "$BASE_HREF"

# 2. 將 build/web 推送到 gh-pages 分支
cd build/web

# 3. 寫入 CNAME 檔案，內容為 camp.bestian.tw
echo "camp.bestian.tw" > CNAME

# 初始化 Git 倉庫（如果不存在）
if [ ! -d .git ]; then
  git init
fi

# 添加所有文件
git add .

# 提交更改
git commit -m "deploy to gh-pages" || true  # 如果沒有變更，繼續執行

# 使用 --force 強制推送到 gh-pages 分支
git push --force $(git -C ../.. remote get-url origin) HEAD:gh-pages


cd ../..

echo "\n部署完成！請到 GitHub Pages 設定 gh-pages 分支為發佈來源。"
