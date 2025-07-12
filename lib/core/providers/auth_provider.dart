import 'package:flutter/material.dart';
import 'package:appointment_system/core/services/auth_service.dart';
import 'package:appointment_system/core/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _currentUser;

  User? get currentUser => _currentUser;

  get isLoading => null;

  Future<void> login(String email, String password) async {
    await _authService.login(email, password);
    // In a real app, fetch user data after successful login
    _currentUser = User(
      uid: 'user123',
      email: email,
      displayName: 'Test User',
      roleId: 'employee',
      companyId: 'company123',
    );
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    await _authService.register(email, password);
    // In a real app, fetch user data after successful registration
    _currentUser = User(
      uid: 'user123',
      email: email,
      displayName: 'New User',
      roleId: 'visitor',
      companyId: 'company123',
    );
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    notifyListeners();
  }

  Future<void> checkCurrentUser() async {
    final uid = await _authService.getCurrentUserUid();
    if (uid != null) {
      // Fetch user details from Firestore or other service
      _currentUser = User(
        uid: uid,
        email: 'test@example.com',
        displayName: 'Existing User',
        roleId: 'manager',
        companyId: 'company123',
      );
    } else {
      _currentUser = null;
    }
    notifyListeners();
  }
}