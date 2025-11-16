#!/bin/sh
set -eu

echo "🧹 コンテナを停止・削除し、永続化ボリュームを削除しています..."
echo ""
# APPコンテナの削除
docker container rm -f backend
# フロントエンドコンテナの削除
docker container rm -f frontend
# DBコンテナの削除
docker container rm -f kondate-db
# DBボリュームの削除
docker volume rm -f kondate-db-data

echo ""
echo "✅ データベースは正常に削除されました. コンテナを再起動するには、VSCodeで再度開くか、以下のコマンドを実行してください:"
echo "code ~/Kondate-app"