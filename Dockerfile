FROM node:24-ubuntu

# root 権限
USER root

# 基本的な開発ツール（Git を含む）
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       bash \
       git \
       openssh-client \
       curl \
       nano \
       sudo \
       ca-certificates \
    && rm -rf /var/lib/apt/lists/*


# Git パス確認（デバッグに便利）
RUN which git && git --version

# corepack 有効化（yarn / pnpm 用）
RUN corepack enable

# node ユーザーに sudo 権限付与（パスワードあり）
RUN usermod -aG sudo node

# Azure CLI（Ubuntu 24.04 にまだ完全対応していないため、失敗しても継続）
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash || echo "Azure CLI install skipped due to OS mismatch"

# Azure Functions Core Tools（v4）
RUN npm install -g azure-functions-core-tools@4 --unsafe-perm true

# 作業ユーザーへ
USER node

# 作業ディレクトリ
WORKDIR /kondate

# DevContainer 用：無限 sleep
CMD ["sleep", "infinity"]
