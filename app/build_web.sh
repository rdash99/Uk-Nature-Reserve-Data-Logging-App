#!/bin/bash

# Web Platform Build Script for UK Nature Reserve App
# This script ensures proper setup for both Google Maps and SQLite on web platforms

echo "🌐 Setting up UK Nature Reserve App for Web Platform..."

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ Error: pubspec.yaml not found. Run this script from the Flutter project root."
    exit 1
fi

# Check if web directory exists
if [ ! -d "web" ]; then
    echo "❌ Error: web directory not found. This doesn't appear to be a Flutter web project."
    exit 1
fi

echo "📋 Pre-build checklist:"

# Check Google Maps API key
if grep -q "YOUR_API_KEY" web/index.html; then
    echo "⚠️  Google Maps API key needs to be set in web/index.html"
    echo "   Replace 'YOUR_API_KEY' with your actual Google Maps API key"
    echo "   Get your key from: https://console.cloud.google.com/"
else
    echo "✅ Google Maps API key appears to be configured"
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean > /dev/null 2>&1

# Get dependencies
echo "📦 Getting Flutter dependencies..."
flutter pub get

if [ $? -ne 0 ]; then
    echo "❌ Failed to get dependencies"
    exit 1
fi

# Try to set up SQLite web binaries
echo "🗄️  Setting up SQLite web binaries..."
if [ -f "tool/setup_web_sqlite.dart" ]; then
    dart tool/setup_web_sqlite.dart
else
    echo "⚠️  Setup script not found, relying on build process"
fi

# Build for web
echo "🏗️  Building for web platform..."
flutter build web --release

if [ $? -ne 0 ]; then
    echo "❌ Web build failed"
    exit 1
fi

# Verify build output
echo "🔍 Verifying build output..."

BUILD_DIR="build/web"

if [ ! -d "$BUILD_DIR" ]; then
    echo "❌ Build directory not found"
    exit 1
fi

# Check for Google Maps script
if grep -q "maps.googleapis.com" "$BUILD_DIR/index.html"; then
    echo "✅ Google Maps API script found in build"
else
    echo "⚠️  Google Maps API script not found in build"
fi

# Check for SQLite WASM binary
if [ -f "$BUILD_DIR/sqlite3.wasm" ]; then
    echo "✅ SQLite WASM binary found in build"
    WASM_SIZE=$(stat -f%z "$BUILD_DIR/sqlite3.wasm" 2>/dev/null || stat -c%s "$BUILD_DIR/sqlite3.wasm" 2>/dev/null)
    echo "   Binary size: $WASM_SIZE bytes"
else
    echo "⚠️  SQLite WASM binary not found in build"
    echo "   Database operations may not work on web platform"
fi

# Check for service worker
if [ -f "$BUILD_DIR/sqflite_sw.js" ]; then
    echo "✅ SQLite service worker found in build"
else
    echo "⚠️  SQLite service worker not found in build"
fi

echo ""
echo "🎉 Web build completed!"
echo ""
echo "📝 Next steps:"
echo "1. If Google Maps API key warning appeared, update web/index.html with your API key"
echo "2. Deploy the contents of build/web/ to your web server"
echo "3. Test both Google Maps functionality and database operations"
echo ""
echo "🚀 To test locally:"
echo "   cd build/web && python3 -m http.server 8000"
echo "   Then open http://localhost:8000 in your browser"
echo ""
echo "📚 For troubleshooting, see:"
echo "   - SQLITE_WEB_FIX.md"
echo "   - WEB_SQLITE_SETUP.md"