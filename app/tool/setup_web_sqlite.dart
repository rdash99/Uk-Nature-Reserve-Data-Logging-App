#!/usr/bin/env dart

import 'dart:io';
import 'dart:convert';

/// Script to set up SQLite web binaries for web platform support
/// This ensures the sqlite3.wasm file is available for sqflite_common_ffi_web

void main() async {
  print('Setting up SQLite web binaries...');
  
  final webDir = Directory('web');
  if (!webDir.existsSync()) {
    print('Error: web directory not found. Run this from the Flutter project root.');
    exit(1);
  }

  // Check if we're in a Flutter project
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    print('Error: pubspec.yaml not found. Run this from the Flutter project root.');
    exit(1);
  }

  // Try to find sqlite3.wasm in package cache
  print('Looking for sqlite3.wasm in package cache...');
  
  try {
    // Run flutter pub deps to get package information
    final result = await Process.run('flutter', ['pub', 'deps']);
    if (result.exitCode != 0) {
      print('Warning: Could not run flutter pub deps');
    }

    // Try to find the file in .dart_tool/package_cache
    final packageCache = Directory('.dart_tool/package_cache');
    if (packageCache.existsSync()) {
      await _searchForSQLiteWasm(packageCache);
    }

    // Also try pub cache
    final pubCacheResult = await Process.run('flutter', ['pub', 'cache', 'repair']);
    if (pubCacheResult.exitCode == 0) {
      // Try to find in pub global cache
      final homeDir = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
      if (homeDir != null) {
        final pubCache = Directory('$homeDir/.pub-cache');
        if (pubCache.existsSync()) {
          await _searchForSQLiteWasm(pubCache);
        }
      }
    }

    // Check if we now have the file
    final wasmFile = File('web/sqlite3.wasm');
    if (wasmFile.existsSync()) {
      print('✅ sqlite3.wasm is available in web directory');
      print('✅ SQLite web setup completed successfully');
    } else {
      print('⚠️  sqlite3.wasm not found in package cache');
      print('⚠️  This may be resolved when running "flutter build web"');
      print('   The sqflite_common_ffi_web package should provide the binary during build');
      
      // Create a placeholder file with instructions
      await wasmFile.writeAsString('# This file should be replaced by flutter build web\n# If this file exists after building, the SQLite web worker may not work properly\n');
      print('📝 Created placeholder file - should be replaced during build');
    }

  } catch (e) {
    print('Error during setup: $e');
    print('You may need to run "flutter pub get" first');
    exit(1);
  }
}

Future<void> _searchForSQLiteWasm(Directory searchDir) async {
  print('Searching in: ${searchDir.path}');
  
  await for (final entity in searchDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('sqlite3.wasm')) {
      print('Found sqlite3.wasm at: ${entity.path}');
      
      // Copy to web directory
      final webFile = File('web/sqlite3.wasm');
      await entity.copy(webFile.path);
      print('✅ Copied sqlite3.wasm to web directory');
      return;
    }
  }
}