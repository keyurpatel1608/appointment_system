import 'package:flutter/material.dart';
import 'package:appointment_system/core/providers/user_provider.dart'; // Re-exporting core UserProvider

// This file can be used to extend or combine UserProvider functionalities
// specific to the 'user_management' feature, if needed. For now, it simply re-exports
// the core UserProvider.

class FeatureUserProvider extends UserProvider {
  FeatureUserProvider() : super();

  // You can add feature-specific user management logic here if necessary
  // For example, handling user invitations, bulk actions, etc.
}