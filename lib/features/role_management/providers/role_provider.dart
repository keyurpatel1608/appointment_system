import 'package:flutter/material.dart';
import 'package:appointment_system/core/providers/role_provider.dart'; // Re-exporting core RoleProvider

// This file can be used to extend or combine RoleProvider functionalities
// specific to the 'role_management' feature, if needed. For now, it simply re-exports
// the core RoleProvider.

class FeatureRoleProvider extends RoleProvider {
  FeatureRoleProvider() : super();

  // You can add feature-specific role management logic here if necessary
  // For example, handling permission assignments, role hierarchy, etc.
}