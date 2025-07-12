import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/role_provider.dart';
import 'package:appointment_system/core/models/role_model.dart';
import 'package:appointment_system/core/utils/validators.dart';
import 'package:appointment_system/config/routes/app_router.dart';

class EditRoleScreen extends StatefulWidget {
  final String roleId;

  const EditRoleScreen({super.key, required this.roleId});

  @override
  State<EditRoleScreen> createState() => _EditRoleScreenState();
}

class _EditRoleScreenState extends State<EditRoleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Role? _currentRole;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRoleData();
  }

  Future<void> _loadRoleData() async {
    try {
      final roleProvider = Provider.of<RoleProvider>(context, listen: false);
      _currentRole = await roleProvider.getRoleById(widget.roleId);
      if (_currentRole != null) {
        _nameController.text = _currentRole!.name;
        _descriptionController.text = _currentRole!.description ?? '';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load role data: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateRole() async {
    if (_formKey.currentState!.validate() && _currentRole != null) {
      final roleProvider = Provider.of<RoleProvider>(context, listen: false);
      try {
        final updatedRole = _currentRole!.copyWith(
          name: _nameController.text,
          description: _descriptionController.text,
          updatedAt: DateTime.now(),
        );
        await roleProvider.updateRole(updatedRole);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Role updated successfully!')), 
        );
        AppRouter.router.pop(); // Go back to role detail or list
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update role: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Role'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _currentRole == null
              ? const Center(child: Text('Role not found.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Role Name'),
                          validator: (value) => Validators.validateEmpty(value, 'Role Name'),
                        ),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(labelText: 'Description'),
                          maxLines: 3,
                          validator: (value) => Validators.validateEmpty(value, 'Description'),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _updateRole,
                          child: const Text('Update Role'),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}