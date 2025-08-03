# Web Platform Fixes - Quick Start

This directory contains fixes for Google Maps and SQLite web platform issues.

## 🚀 Quick Setup

1. **Configure Google Maps API Key:**
   - Edit `web/index.html`
   - Replace `YOUR_API_KEY` with your Google Maps API key

2. **Build for Web:**
   ```bash
   ./build_web.sh
   ```

3. **Deploy:**
   Upload `build/web/` contents to your web server

## 📚 Documentation

- `WEB_PLATFORM_GUIDE.md` - Complete setup guide
- `SQLITE_WEB_FIX.md` - SQLite troubleshooting
- `WEB_SQLITE_SETUP.md` - Original SQLite documentation

## 🛠️ Tools

- `build_web.sh` - Automated build script
- `tool/setup_web_sqlite.dart` - SQLite binary setup

## ✅ Issues Fixed

- Google Maps JavaScript API integration
- SQLite web worker timeout issues
- Enhanced error handling and documentation