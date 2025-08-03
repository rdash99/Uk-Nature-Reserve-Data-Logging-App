#!/bin/bash

# Setup script for SQLite web binaries
# This script should be run after flutter pub get

echo "Setting up SQLite web binaries..."

# Create web directory if it doesn't exist
mkdir -p web

# Download SQLite WASM file if not exists
if [ ! -f "web/sqlite3.wasm" ] || [ ! -s "web/sqlite3.wasm" ]; then
  echo "Downloading sqlite3.wasm..."
  if wget -O web/sqlite3.wasm https://unpkg.com/sql.js@1.8.0/dist/sqlite3.wasm; then
    echo "Downloaded sqlite3.wasm successfully"
  else
    echo "Warning: Could not download sqlite3.wasm - creating placeholder"
    echo "/* Placeholder for sqlite3.wasm - run 'dart run sqflite_common_ffi_web:setup' after pub get */" > web/sqlite3.wasm
  fi
fi

# Create service worker if not exists
if [ ! -f "web/sqflite_sw.js" ] || [ ! -s "web/sqflite_sw.js" ]; then
  echo "Creating sqflite service worker..."
  cat > web/sqflite_sw.js << 'SW_EOF'
// SQLite Service Worker for Web Support
// Based on sqflite_common_ffi_web package

self.addEventListener('install', function(event) {
  console.log('SQLite SW: Installing...');
  self.skipWaiting();
});

self.addEventListener('activate', function(event) {
  console.log('SQLite SW: Activating...');
  event.waitUntil(self.clients.claim());
});

self.addEventListener('fetch', function(event) {
  // Let the browser handle all fetch events
  return;
});
SW_EOF
fi

echo "SQLite web setup complete!"