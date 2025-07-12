import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileProvider extends ChangeNotifier {
  // Example user profile data
  Map<String, dynamic> _userProfile = {
    'displayName': 'John Doe',
    'email': 'john.doe@example.com',
    'role': 'Employee',
    'company': 'Example Corp',
  };

  Map<String, dynamic> get userProfile => _userProfile;

  // Simulate fetching user profile
  Future<void> fetchUserProfile() async {
    // In a real application, this would involve an API call
    await Future.delayed(const Duration(seconds: 1));
    // Update data after fetching
    _userProfile = {
      'displayName': 'John Doe Updated',
      'email': 'john.doe@example.com',
      'role': 'Manager',
      'company': 'Example Corp',
    };
    notifyListeners();
  }

  // Simulate updating user profile
  Future<void> updateUserProfile(Map<String, dynamic> newData) async {
    // In a real application, this would involve an API call
    await Future.delayed(const Duration(seconds: 1));
    _userProfile.addAll(newData);
    notifyListeners();
  }

  // You can add more methods here for managing settings, e.g., updateNotificationSettings()
}

final profileProvider = ChangeNotifierProvider((ref) => ProfileProvider());