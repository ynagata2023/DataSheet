@echo off
REM クライアントのビルド
cd datasheet.client
call npm install
call npm run build
cd ..

REM サーバーのwwwrootフォルダをクリア
rmdir /s /q DataSheet.Server\wwwroot
mkdir DataSheet.Server\wwwroot

REM ビルド済みファイルをコピー
xcopy /E /Y /I datasheet.client\dist\* DataSheet.Server\wwwroot\