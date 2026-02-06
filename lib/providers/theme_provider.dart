import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeModeKey = 'isDarkMode';

  bool _isDarkMode = false;

  ThemeProvider._();
  static final ThemeProvider _instance = ThemeProvider._();

  factory ThemeProvider() {
    return _instance;
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeModeKey) ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeModeKey, _isDarkMode);
    notifyListeners();
  }
}
