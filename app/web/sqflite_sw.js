// SQLite Service Worker for Web Support
// Enhanced implementation for sqflite_common_ffi_web with better error handling

self.addEventListener('install', function(event) {
  console.log('SQLite SW: Installing service worker...');
  self.skipWaiting();
});

self.addEventListener('activate', function(event) {
  console.log('SQLite SW: Activating service worker...');
  event.waitUntil(self.clients.claim());
});

self.addEventListener('fetch', function(event) {
  // Handle SQLite WASM file requests
  if (event.request.url.endsWith('sqlite3.wasm')) {
    console.log('SQLite SW: Intercepting sqlite3.wasm request for:', event.request.url);
    
    // Check if the file exists and provide helpful error messages
    event.respondWith(
      fetch(event.request).catch(function(error) {
        console.error('SQLite SW: Failed to fetch sqlite3.wasm:', error);
        console.error('SQLite SW: Make sure "flutter build web" was run to include SQLite binaries');
        
        // Return a helpful error response
        return new Response(
          'SQLite WASM binary not found. Run "flutter build web" to include SQLite binaries.',
          { 
            status: 404, 
            statusText: 'SQLite Binary Not Found',
            headers: { 'Content-Type': 'text/plain' }
          }
        );
      })
    );
  }
  // Let all other requests pass through normally
});