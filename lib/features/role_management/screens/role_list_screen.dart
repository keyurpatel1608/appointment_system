import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/role_provider.dart';
import 'package:appointment_system/core/models/role_model.dart';
import 'package:appointment_system/config/routes/app_router.dart';

class RoleListScreen extends StatefulWidget {
  const RoleListScreen({super.key});

  @override
  State<RoleListScreen> createState() => _RoleListScreenState();
}

class _RoleListScreenState extends State<RoleListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch roles when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RoleProvider>(context, listen: false).fetchRoles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role Management'),
      ),
      body: Consumer<RoleProvider>(
        builder: (context, roleProvider, child) {
          if (roleProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (roleProvider.roles.isEmpty) {
            return const Center(child: Text('No roles found.'));
          } else {
            return ListView.builder(
              itemCount: roleProvider.roles.length,
              itemBuilder: (context, index) {
                final role = roleProvider.roles[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(role.name),
                    subtitle: Text(role.description ?? 'No description'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Navigate to edit role screen
                            AppRouter.router.go('${AppRouter.editRoleRoute}/${role.id}');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _confirmDelete(context, role);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigate to role detail screen
                      AppRouter.router.go('${AppRouter.roleDetailRoute}/${role.id}');
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add new role screen
          AppRouter.router.go(AppRouter.addRoleRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Role role) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: Text('Are you sure you want to delete role ${role.name}?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Provider.of<RoleProvider>(context, listen: false).deleteRole(role.id!);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}