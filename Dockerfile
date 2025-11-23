# backend 用 Dockerfile
FROM mcr.microsoft.com/azure-functions/node:4-node24

# root 権限のまま
USER root

# 開発に必要なツールを追加
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    bash \
    curl \
    sudo \
    nano \
    less \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを /kondate に統一
WORKDIR /kondate

# DevContainer 用：無限 sleep
CMD ["sleep", "infinity"]
