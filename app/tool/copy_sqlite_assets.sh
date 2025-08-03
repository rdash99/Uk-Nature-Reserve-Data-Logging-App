# SQLite Web Assets Post-Build Script
# This script should be run after flutter build web

#!/bin/bash

BUILD_DIR="build/web"
WEB_DIR="web"

echo "Copying SQLite web assets..."

# Ensure the build directory exists
if [ ! -d "$BUILD_DIR" ]; then
    echo "Build directory not found. Please run 'flutter build web' first."
    exit 1
fi

# Copy service worker if it exists
if [ -f "$WEB_DIR/sqflite_sw.js" ]; then
    cp "$WEB_DIR/sqflite_sw.js" "$BUILD_DIR/"
    echo "Copied sqflite_sw.js"
fi

# Check if sqlite3.wasm exists in build output
if [ ! -f "$BUILD_DIR/sqlite3.wasm" ]; then
    echo "Warning: sqlite3.wasm not found in build output"
    echo "This file should be automatically included by sqflite_common_ffi_web"
fi

echo "SQLite web assets setup complete"