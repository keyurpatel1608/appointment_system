import 'package:flutter/foundation.dart';

class SettingsProvider with ChangeNotifier {
  // Example setting
  bool _enableNotifications = true;

  bool get enableNotifications => _enableNotifications;

  void toggleNotifications(bool newValue) {
    _enableNotifications = newValue;
    notifyListeners();
  }

  // Add more settings as needed
}