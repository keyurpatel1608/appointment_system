import 'package:flutter/material.dart';
import 'package:appointment_system/core/providers/auth_provider.dart'; // Re-exporting core AuthProvider

// This file can be used to extend or combine AuthProvider functionalities
// specific to the 'auth' feature, if needed. For now, it simply re-exports
// the core AuthProvider.

class FeatureAuthProvider extends AuthProvider {
  FeatureAuthProvider() : super();

  // You can add feature-specific authentication logic here if necessary
  // For example, handling social logins specific to this feature, etc.
}