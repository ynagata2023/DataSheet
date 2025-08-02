# 1. Node.js + .NET SDK の組み合わせ（build stage）
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS server-build

# Node.js を手動インストール（Debianベース）
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/* && \
    node -v && npm -v

WORKDIR /src

# プロジェクトファイルのみ先にコピー＆リストア
COPY DataSheet.Server/*.csproj ./DataSheet.Server/
RUN dotnet restore ./DataSheet.Server/DataSheet.Server.csproj

# 残りのコードをコピー
COPY . ./

# パブリッシュ（Reactビルド含む）
RUN dotnet publish ./DataSheet.Server/DataSheet.Server.csproj -c Release -o /app/publish

# 2. ランタイムのみの軽量イメージ
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

WORKDIR /app

COPY --from=server-build /app/publish ./

ENV ASPNETCORE_ENVIRONMENT=Production
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80

ENTRYPOINT ["dotnet", "DataSheet.Server.dll"]
