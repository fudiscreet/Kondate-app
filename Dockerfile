FROM node:24

# 必要な開発ツール
USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      bash git openssh-client curl nano sudo \
    && rm -rf /var/lib/apt/lists/*

# yarn / pnpm を corepack で管理
RUN corepack enable

# node ユーザーに sudo を付与（パスワード要求ありの安全設定）
RUN usermod -aG sudo node

# Azure Functions Core Tools（v4）をインストール
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
    npm install -g azure-functions-core-tools@4 --unsafe-perm true

# 作業ユーザー
USER node

# 作業フォルダ
WORKDIR /kondate

# デフォルトは sleep（VSCode Dev Containers / compose 用）
CMD ["sleep", "infinity"]
