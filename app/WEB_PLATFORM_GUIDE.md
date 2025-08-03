# Web Platform Setup Guide

This guide provides complete instructions for resolving Google Maps and SQLite issues on web platforms.

## 🐛 Issues Fixed

### 1. Google Maps TypeError
**Error:** `TypeError: Cannot read properties of undefined (reading 'maps')`

**Root Cause:** Missing Google Maps JavaScript API script in web/index.html

**Resolution:** Added Google Maps JavaScript API script tag with API key placeholder

### 2. SQLite Web Worker Timeout  
**Error:** `Database initialization timed out after 30 seconds`

**Root Cause:** Missing sqlite3.wasm binary for SQLite web worker

**Resolution:** Enhanced build process to ensure proper SQLite web setup

## 🔧 Setup Instructions

### Step 1: Configure Google Maps API

1. **Get API Key:**
   - Go to [Google Cloud Console](https://console.cloud.google.com/)
   - Create or select a project
   - Enable "Maps JavaScript API"
   - Create credentials (API Key)

2. **Update web/index.html:**
   ```html
   <!-- Replace YOUR_API_KEY with your actual key -->
   <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_ACTUAL_API_KEY"></script>
   ```

### Step 2: Build for Web Platform

Use the provided build script for automated setup:

```bash
# Make script executable (if not already)
chmod +x build_web.sh

# Run the complete web setup and build
./build_web.sh
```

Or manually:

```bash
# Clean and get dependencies
flutter clean
flutter pub get

# Build for web (includes SQLite binaries)
flutter build web --release
```

### Step 3: Deploy and Test

1. **Deploy build output:**
   Upload contents of `build/web/` to your web server

2. **Test locally:**
   ```bash
   cd build/web
   python3 -m http.server 8000
   # Open http://localhost:8000
   ```

3. **Verify functionality:**
   - Google Maps displays correctly
   - User registration/login works
   - Database operations complete without timeout

## 🛠️ Development vs Production

### Development Mode (`flutter run -d web-server`)
- ⚠️ SQLite web worker may timeout (expected behavior)
- ⚠️ Google Maps may not load without proper API key setup
- ✅ Good for UI development and testing non-database features

### Production Mode (`flutter build web`)
- ✅ SQLite web worker functions properly with included binaries
- ✅ Google Maps works with proper API key configuration  
- ✅ All features should work as expected

## 📁 File Changes Made

### Enhanced Files:
- `web/index.html` - Added Google Maps JavaScript API
- `web/sqflite_sw.js` - Enhanced service worker with error handling
- `lib/database/database_helper.dart` - Better error messages and timeout handling

### New Files:
- `tool/setup_web_sqlite.dart` - SQLite binary setup script
- `build_web.sh` - Automated web build script
- Updated documentation files

## 🔍 Troubleshooting

### Google Maps Issues:
- **Problem:** Maps don't load
- **Solution:** Verify API key is correct and Maps JavaScript API is enabled

### SQLite Issues:
- **Problem:** Database timeouts persist
- **Solution:** Ensure `flutter build web` was used (not `flutter run`)
- **Check:** Verify `sqlite3.wasm` exists in `build/web/` directory

### General Web Issues:
- Clear browser cache after rebuilding
- Check browser console for JavaScript errors
- Ensure you're testing the built app, not development server

## 🎯 Success Criteria

After completing setup, you should have:
- ✅ Google Maps displaying correctly
- ✅ User registration/login working
- ✅ Database operations completing successfully
- ✅ No browser console errors
- ✅ App starting without hanging

## 📚 Additional Resources

- [Google Maps JavaScript API Documentation](https://developers.google.com/maps/documentation/javascript)
- [Flutter Web Deployment Guide](https://docs.flutter.dev/deployment/web)
- [SQLite Web Setup Documentation](https://github.com/tekartik/sqflite/tree/master/packages_web/sqflite_common_ffi_web)

For specific issues, see also:
- `SQLITE_WEB_FIX.md` - Detailed SQLite troubleshooting
- `WEB_SQLITE_SETUP.md` - Original SQLite setup guide