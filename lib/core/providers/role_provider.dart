import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/role_model.dart';
import 'package:appointment_system/core/services/firestore_service.dart';

class RoleProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Role> _roles = [];

  List<Role> get roles => _roles;

  Future<void> fetchRoles(String companyId) async {
    // In a real app, you'd query roles for a specific company
    _roles = await _firestoreService.streamCollection<Role>('companies/$companyId/roles', Role.fromJson).first;
    notifyListeners();
  }

  Future<void> addRole(String companyId, Role role) async {
    await _firestoreService.addDocument('companies/$companyId/roles', role.toJson());
    await fetchRoles(companyId);
  }

  Future<void> updateRole(String companyId, Role role) async {
    await _firestoreService.updateDocument('companies/$companyId/roles', role.id!, role.toJson());
    await fetchRoles(companyId);
  }

  Future<void> deleteRole(String companyId, String roleId) async {
    await _firestoreService.deleteDocument('companies/$companyId/roles', roleId);
    await fetchRoles(companyId);
  }
}