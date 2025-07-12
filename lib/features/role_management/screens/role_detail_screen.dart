import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/role_provider.dart';
import 'package:appointment_system/core/models/role_model.dart';
import 'package:appointment_system/config/routes/app_router.dart';

class RoleDetailScreen extends StatefulWidget {
  final String roleId;

  const RoleDetailScreen({super.key, required this.roleId});

  @override
  State<RoleDetailScreen> createState() => _RoleDetailScreenState();
}

class _RoleDetailScreenState extends State<RoleDetailScreen> {
  Role? _role;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRoleDetail();
  }

  Future<void> _fetchRoleDetail() async {
    try {
      final roleProvider = Provider.of<RoleProvider>(context, listen: false);
      final role = await roleProvider.getRoleById(widget.roleId);
      setState(() {
        _role = role;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error, e.g., show a snackbar
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load role details: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role Details'),
        actions: [
          if (_role != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                AppRouter.router.go('${AppRouter.editRoleRoute}/${widget.roleId}');
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _role == null
              ? const Center(child: Text('Role not found.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Role Name: ${_role!.name}',
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Description: ${_role!.description ?? 'N/A'}',
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Company ID: ${_role!.companyId ?? 'N/A'}',
                          style: const TextStyle(fontSize: 18)),
                      // Add more role details as needed, e.g., permissions
                    ],
                  ),
                ),
    );
  }
}