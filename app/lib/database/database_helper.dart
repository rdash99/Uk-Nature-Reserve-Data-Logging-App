import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  static bool _initialized = false;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  /// Initialize the database factory for the current platform
  static void _initializeDatabaseFactory() {
    if (_initialized) return;
    
    try {
      if (kIsWeb) {
        // For web platforms, use the web-specific FFI database factory
        databaseFactory = databaseFactoryFfiWeb;
        print('DatabaseHelper: Initialized for web platform with databaseFactoryFfiWeb');
      } else if (Platform.isWindows || Platform.isLinux) {
        // For desktop platforms, use FFI database factory
        databaseFactory = databaseFactoryFfi;
        sqfliteFfiInit();
        print('DatabaseHelper: Initialized for desktop platform with databaseFactoryFfi');
      } else {
        // For mobile platforms (Android/iOS), the default sqflite factory is used
        print('DatabaseHelper: Using default sqflite factory for mobile platform');
      }
    } catch (e) {
      print('DatabaseHelper: Error during initialization: $e');
      rethrow;
    }
    
    _initialized = true;
  }

  Future<Database> get database async {
    try {
      _initializeDatabaseFactory();
      if (_database != null) return _database!;
      _database = await _initDB();
      return _database!;
    } catch (e) {
      print('DatabaseHelper: Error getting database: $e');
      if (kIsWeb) {
        print('DatabaseHelper: Web platform SQLite setup issue. Please check WEB_SQLITE_SETUP.md');
        print('DatabaseHelper: Make sure sqflite_sw.js and sqlite3.wasm are in the web/ directory');
      }
      rethrow;
    }
  }

  Future<Database> _initDB() async {
    String path;
    if (kIsWeb) {
      // For web platforms, use a simple filename
      path = 'nature_reserve.db';
      
      // Check if web SQLite binaries are available
      await _checkWebSQLiteSetup();
    } else {
      // For mobile/desktop platforms, use the standard database path
      path = join(await getDatabasesPath(), 'nature_reserve.db');
    }
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  /// Check if web SQLite setup is properly configured
  Future<void> _checkWebSQLiteSetup() async {
    if (!kIsWeb) return;
    
    print('DatabaseHelper: Checking web SQLite setup...');
    // The actual files will be checked by the sqflite_common_ffi_web package
    // This method serves as a placeholder for future setup validation
  }

  Future<void> _createDB(Database db, int version) async {
    // Create Users table
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        email TEXT UNIQUE NOT NULL,
        password_hash TEXT NOT NULL,
        first_name TEXT NOT NULL,
        surname TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Create Butterfly Sightings table
    await db.execute('''
      CREATE TABLE butterfly_sightings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        species TEXT NOT NULL,
        number_seen INTEGER NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');

    // Create Bird Sightings table (for future use)
    await db.execute('''
      CREATE TABLE bird_sightings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        species TEXT NOT NULL,
        number_seen INTEGER NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');
  }

  // User operations
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    try {
      await db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.abort);
      return 1; // Success
    } catch (e) {
      return 0; // Failed (likely duplicate email)
    }
  }

  Future<Map<String, dynamic>?> getUser(String email, String passwordHash) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password_hash = ?',
      whereArgs: [email, passwordHash],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Butterfly sighting operations
  Future<int> insertButterflySighting(Map<String, dynamic> sighting) async {
    final db = await database;
    return await db.insert('butterfly_sightings', sighting);
  }

  Future<List<Map<String, dynamic>>> getButterflySightings(String userId) async {
    final db = await database;
    return await db.query(
      'butterfly_sightings',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getAllButterflySightings() async {
    final db = await database;
    return await db.query(
      'butterfly_sightings',
      orderBy: 'created_at DESC',
    );
  }

  // Bird sighting operations (for future use)
  Future<int> insertBirdSighting(Map<String, dynamic> sighting) async {
    final db = await database;
    return await db.insert('bird_sightings', sighting);
  }

  Future<List<Map<String, dynamic>>> getBirdSightings(String userId) async {
    final db = await database;
    return await db.query(
      'bird_sightings',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
    );
  }

  // Export data for potential future sync
  Future<Map<String, dynamic>> exportUserData(String userId) async {
    final db = await database;
    
    final user = await db.query('users', where: 'id = ?', whereArgs: [userId]);
    final butterflySightings = await getButterflySightings(userId);
    final birdSightings = await getBirdSightings(userId);
    
    return {
      'user': user.isNotEmpty ? user.first : null,
      'butterfly_sightings': butterflySightings,
      'bird_sightings': birdSightings,
      'export_timestamp': DateTime.now().toIso8601String(),
    };
  }
}