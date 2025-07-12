import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/user_model.dart';
import 'package:appointment_system/core/services/firestore_service.dart';

class UserProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<User> _users = [];

  List<User> get users => _users;

  Future<void> fetchUsers() async {
    // In a real app, you'd filter by companyId or other criteria
    _users = await _firestoreService.streamCollection<User>('users', User.fromJson).first;
    notifyListeners();
  }

  Future<void> addUser(User user) async {
    await _firestoreService.addDocument('users', user.toJson());
    await fetchUsers(); // Refresh list
  }

  Future<void> updateUser(User user) async {
    await _firestoreService.updateDocument('users', user.uid, user.toJson());
    await fetchUsers(); // Refresh list
  }

  Future<void> deleteUser(String userId) async {
    await _firestoreService.deleteDocument('users', userId);
    await fetchUsers(); // Refresh list
  }

  Future<User?> getUserById(String userId) async {
    final doc = await _firestoreService.getDocumentById('users', userId);
    if (doc != null) {
      return User.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }
}