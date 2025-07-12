import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  void toggleDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }

  // Add other settings related state and logic here
}