import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appointment_system/core/providers/auth_provider.dart'; // Assuming AuthProvider exists

class PermissionWrapper extends ConsumerWidget {
  final Widget child;
  final List<String> requiredPermissions;
  final Widget? unauthorizedWidget;

  const PermissionWrapper({
    super.key,
    required this.child,
    required this.requiredPermissions,
    this.unauthorizedWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    bool hasPermission = authState.isAuthenticated &&
        requiredPermissions.any((permission) =>
            authState.user?.permissions.contains(permission) ?? false);

    if (hasPermission) {
      return child;
    } else {
      return unauthorizedWidget ??
          const SizedBox.shrink(); // Or a default unauthorized message
    }
  }
}