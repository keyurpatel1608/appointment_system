import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Assuming you have an AuthProvider and PermissionService
// import '../core/providers/auth_provider.dart';
// import '../core/services/permission_service.dart';

class PermissionGuard extends ConsumerWidget {
  final Widget child;
  final String requiredPermission;

  const PermissionGuard({
    super.key,
    required this.child,
    required this.requiredPermission,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authState = ref.watch(authProvider);
    // final permissionService = ref.watch(permissionServiceProvider);

    // TODO: Implement actual permission checking logic
    // For now, always allow access
    bool hasPermission = true; // permissionService.hasPermission(requiredPermission);

    if (hasPermission) {
      return child;
    } else {
      // Redirect to an unauthorized access screen or login
      return const Scaffold(
        body: Center(
          child: Text('Unauthorized Access'),
        ),
      );
    }
  }
}

// Example of how to use it with GoRouter (conceptual)
// GoRoute(
//   path: '/admin',
//   builder: (context, state) => PermissionGuard(
//     requiredPermission: 'SYSTEM_ADMIN',
//     child: AdminDashboard(),
//   ),
// ),