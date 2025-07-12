import 'package:appointment_system/core/constants/permission_constants.dart';
import 'package:appointment_system/core/models/role_model.dart';

class PermissionUtils {
  static bool hasPermission(Role role, String permission) {
    return role.permissions.contains(permission);
  }

  static bool hasAnyPermission(Role role, List<String> permissions) {
    return permissions.any((p) => role.permissions.contains(p));
  }

  static bool hasAllPermissions(Role role, List<String> permissions) {
    return permissions.every((p) => role.permissions.contains(p));
  }

  // Example of a more complex permission check based on role level
  static bool canManageUsers(Role role) {
    return role.level <= 2; // e.g., Super Admin, CEO, Manager can manage users
  }
}