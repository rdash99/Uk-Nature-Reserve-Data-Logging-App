// SQLite Service Worker for Web Support
// Minimal implementation for sqflite_common_ffi_web

self.addEventListener('install', function(event) {
  console.log('SQLite SW: Installing...');
  self.skipWaiting();
});

self.addEventListener('activate', function(event) {
  console.log('SQLite SW: Activating...');
  event.waitUntil(self.clients.claim());
});

self.addEventListener('fetch', function(event) {
  // Handle SQLite WASM file requests
  if (event.request.url.endsWith('sqlite3.wasm')) {
    console.log('SQLite SW: Intercepting sqlite3.wasm request');
    // For now, let it pass through
  }
  // Let all other requests pass through
});