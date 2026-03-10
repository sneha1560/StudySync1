import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userEmail = prefs.getString('userEmail');
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    // Stub: Replace with actual Google Sign-In
    _isLoggedIn = true;
    _userEmail = 'user@example.com';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userEmail', _userEmail!);
    notifyListeners();
  }

  Future<void> signOut() async {
    _isLoggedIn = false;
    _userEmail = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userEmail');
    notifyListeners();
  }
}
