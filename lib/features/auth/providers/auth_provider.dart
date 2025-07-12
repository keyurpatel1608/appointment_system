import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isAuthenticated = false;
  User? _user;
  Map<String, dynamic>? _userData;

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getters
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  User? get user => _user;
  Map<String, dynamic>? get userData => _userData;
  String? get userId => _user?.uid;
  String? get userEmail => _user?.email;
  String? get userName => _userData?['name'];

  AuthProvider() {
    _initAuthListener();
  }

  // Initialize auth state listener
  void _initAuthListener() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _user = user;
        _isAuthenticated = true;
        _loadUserData();
      } else {
        _user = null;
        _isAuthenticated = false;
        _userData = null;
      }
      notifyListeners();
    });
  }

  // Load user data from Firestore
  Future<void> _loadUserData() async {
    if (_user != null) {
      try {
        DocumentSnapshot doc = await _firestore
            .collection('users')
            .doc(_user!.uid)
            .get();

        if (doc.exists) {
          _userData = doc.data() as Map<String, dynamic>?;
        }
      } catch (e) {
        print('Error loading user data: $e');
      }
    }
  }

  // Login method
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = result.user;
      _isAuthenticated = true;

      // Load user data from Firestore
      await _loadUserData();

      // Save login state
      await _saveLoginState();
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e.code);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Register method
  Future<void> register(String email, String password, String name) async {
    _isLoading = true;
    notifyListeners();

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = result.user;
      _isAuthenticated = true;

      // Update display name
      await _user!.updateDisplayName(name);

      // Create user document in Firestore
      await _createUserDocument(name);

      // Save login state
      await _saveLoginState();
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e.code);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create user document in Firestore
  Future<void> _createUserDocument(String name) async {
    if (_user != null) {
      try {
        await _firestore.collection('users').doc(_user!.uid).set({
          'name': name,
          'email': _user!.email,
          'uid': _user!.uid,
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
        });

        // Load the created user data
        await _loadUserData();
      } catch (e) {
        print('Error creating user document: $e');
      }
    }
  }

  // Update user profile
  Future<void> updateProfile(Map<String, dynamic> userData) async {
    if (_user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      // Update in Firestore
      await _firestore.collection('users').doc(_user!.uid).update({
        ...userData,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update display name if provided
      if (userData.containsKey('name')) {
        await _user!.updateDisplayName(userData['name']);
      }

      // Reload user data
      await _loadUserData();
    } catch (e) {
      throw Exception('Profile update failed: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout method
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _auth.signOut();
      _user = null;
      _isAuthenticated = false;
      _userData = null;

      // Clear saved login state
      await _clearLoginState();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e.code);
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('Password reset failed: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Auto login check
  Future<void> tryAutoLogin() async {
    _isLoading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      if (isLoggedIn && _auth.currentUser != null) {
        _user = _auth.currentUser;
        _isAuthenticated = true;
        await _loadUserData();
      }
    } catch (e) {
      print('Auto login failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Save login state to SharedPreferences
  Future<void> _saveLoginState() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      if (_user?.uid != null) {
        await prefs.setString('userId', _user!.uid);
      }
    } catch (e) {
      print('Error saving login state: $e');
    }
  }

  // Clear login state from SharedPreferences
  Future<void> _clearLoginState() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      await prefs.remove('userId');
    } catch (e) {
      print('Error clearing login state: $e');
    }
  }

  // Get user appointments (example of database query)
  Future<List<Map<String, dynamic>>> getUserAppointments() async {
    if (_user == null) return [];

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('appointments')
          .where('userId', isEqualTo: _user!.uid)
          .orderBy('appointmentDate', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching appointments: $e');
      return [];
    }
  }

  // Create appointment (example of database write)
  Future<void> createAppointment(Map<String, dynamic> appointmentData) async {
    if (_user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _firestore.collection('appointments').add({
        ...appointmentData,
        'userId': _user!.uid,
        'userEmail': _user!.email,
        'userName': _userData?['name'] ?? 'Unknown',
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });
    } catch (e) {
      throw Exception('Failed to create appointment: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update last login timestamp
  Future<void> updateLastLogin() async {
    if (_user != null) {
      try {
        await _firestore.collection('users').doc(_user!.uid).update({
          'lastLogin': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        print('Error updating last login: $e');
      }
    }
  }

  // Get error message from Firebase Auth error codes
  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  @override
  void dispose() {
    _database?.close();
    super.dispose();
  }
}
