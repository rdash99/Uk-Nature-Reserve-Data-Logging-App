# Web SQLite Setup

This Flutter app uses SQLite on the web platform through the `sqflite_common_ffi_web` package.

## Setup Instructions

After running `flutter pub get`, you need to copy the SQLite binaries to the web directory:

```bash
# Copy SQLite binaries for web support
cp $(flutter packages pub deps | grep sqflite_common_ffi_web | grep -o '[^ ]*')/lib/src/web/assets/sql.js web/
cp $(flutter packages pub deps | grep sqflite_common_ffi_web | grep -o '[^ ]*')/lib/src/web/assets/sqlite3.wasm web/
```

Or run the setup script:
```bash
./tool/setup_web_sqlite.sh
```

## Build Instructions

To build for web:
```bash
flutter build web
```

The build process should automatically include the necessary SQLite binaries.

## Files Required

- `web/sqflite_sw.js` - Service worker (included)
- `web/sqlite3.wasm` - SQLite WebAssembly binary (auto-generated during build)