import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/database_helper.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  static const String _currentUserKey = 'current_user_id';
  static const String _isLoggedInKey = 'is_logged_in';
  
  AuthService._internal();
  
  factory AuthService() {
    return _instance;
  }

  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Generate a simple user ID
  String _generateUserId() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomNum = random.nextInt(9999);
    return 'user_${timestamp}_$randomNum';
  }

  // Hash password
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Sign up new user
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String firstName,
    required String surname,
  }) async {
    try {
      // Check if user already exists
      final existingUser = await _dbHelper.getUserByEmail(email);
      if (existingUser != null) {
        return AuthResult(success: false, error: 'email-already-in-use');
      }

      // Validate password strength
      if (password.length < 6) {
        return AuthResult(success: false, error: 'weak-password');
      }

      // Create new user
      final userId = _generateUserId();
      final passwordHash = _hashPassword(password);
      
      final user = {
        'id': userId,
        'email': email,
        'password_hash': passwordHash,
        'first_name': firstName,
        'surname': surname,
        'created_at': DateTime.now().toIso8601String(),
      };

      final result = await _dbHelper.insertUser(user);
      if (result == 1) {
        // Store current user session
        await _storeCurrentUser(userId);
        return AuthResult(success: true, userId: userId);
      } else {
        return AuthResult(success: false, error: 'registration-failed');
      }
    } catch (e) {
      print('AuthService: Sign up error: $e');
      return AuthResult(success: false, error: 'database-error');
    }
  }

  // Sign in existing user
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final passwordHash = _hashPassword(password);
      final user = await _dbHelper.getUser(email, passwordHash);
      
      if (user != null) {
        await _storeCurrentUser(user['id']);
        return AuthResult(success: true, userId: user['id']);
      } else {
        // Check if user exists with different password
        final existingUser = await _dbHelper.getUserByEmail(email);
        if (existingUser != null) {
          return AuthResult(success: false, error: 'wrong-password');
        } else {
          return AuthResult(success: false, error: 'user-not-found');
        }
      }
    } catch (e) {
      print('AuthService: Sign in error: $e');
      return AuthResult(success: false, error: 'database-error');
    }
  }

  // Sign out
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Get current user
  Future<String?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    if (isLoggedIn) {
      return prefs.getString(_currentUserKey);
    }
    return null;
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get current user details
  Future<Map<String, dynamic>?> getCurrentUser() async {
    final userId = await getCurrentUserId();
    if (userId != null) {
      final db = await _dbHelper.database;
      final result = await db.query('users', where: 'id = ?', whereArgs: [userId]);
      return result.isNotEmpty ? result.first : null;
    }
    return null;
  }

  // Store current user session
  Future<void> _storeCurrentUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, userId);
    await prefs.setBool(_isLoggedInKey, true);
  }
}

class AuthResult {
  final bool success;
  final String? userId;
  final String? error;

  AuthResult({required this.success, this.userId, this.error});
}

// Stream-like user state management for compatibility
class UserState {
  static final UserState _instance = UserState._internal();
  static final List<Function(String?)> _listeners = [];
  
  UserState._internal();
  
  factory UserState() {
    return _instance;
  }

  void addListener(Function(String?) listener) {
    _listeners.add(listener);
  }

  void removeListener(Function(String?) listener) {
    _listeners.remove(listener);
  }

  void notifyListeners(String? userId) {
    for (final listener in _listeners) {
      listener(userId);
    }
  }
}