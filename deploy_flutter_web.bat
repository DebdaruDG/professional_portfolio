@echo off
echo 🔄 Cleaning previous builds...
call flutter clean

echo 📦 Fetching dependencies...
call flutter pub get

echo 🛠️ Building release version for web...
call flutter build web

echo 🚀 Deploying to Firebase Hosting...
call firebase deploy

echo ✅ Deployment Complete!
pause
