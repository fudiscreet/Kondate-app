#!/bin/bash -ex

# ----------------------------
# 基本セットアップ
# ----------------------------
tee -a ~/.profile <<'EOF'
cp /etc/hosts ~/hosts
sed -i  's/127.0.0.1\tlocalhost/0.0.0.0 localhost/' ~/hosts
sudo cp -f ~/hosts /etc/hosts
rm ~/hosts
EOF

source ~/.profile

# 権限調整
user_name=$(whoami)
mkdir -p ~/.npm
sudo chown -R "$user_name:$user_name" "$HOME/.npm"

# ----------------------------
# Backend (TypeScript) セットアップ
# ----------------------------
if [ -f package.json ]; then
  echo "📦 Installing backend dependencies..."
  npm ci
fi

# ----------------------------
# Frontend (React) セットアップ
# ----------------------------
if [ -d ./frontend ] && [ -f ./frontend/package.json ]; then
  echo "📦 Installing frontend dependencies..."
  cd ./frontend
  npm ci
  cd ..
fi

# Azure Functions プロジェクト初期化
if [ ! -f "host.json" ]; then
  echo "Initializing Azure Functions project..."
  func init . --javascript
fi

echo "Devcontainer setup complete!"