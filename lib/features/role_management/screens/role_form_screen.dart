import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/models/role_model.dart';
import 'package:appointment_system/core/providers/role_provider.dart';

class RoleFormScreen extends StatefulWidget {
  final Role? role;

  const RoleFormScreen({super.key, this.role});

  @override
  State<RoleFormScreen> createState() => _RoleFormScreenState();
}

class _RoleFormScreenState extends State<RoleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.role?.name ?? '');
    _descriptionController = TextEditingController(text: widget.role?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveRole() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final roleProvider = Provider.of<RoleProvider>(context, listen: false);

      if (widget.role == null) {
        // Add new role
        final newRole = Role(
          id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
          name: _nameController.text,
          description: _descriptionController.text,
          companyId: 'company123', // Placeholder
        );
        roleProvider.addRole(newRole);
      } else {
        // Update existing role
        final updatedRole = widget.role!.copyWith(
          name: _nameController.text,
          description: _descriptionController.text,
        );
        roleProvider.updateRole(updatedRole);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.role == null ? 'Add Role' : 'Edit Role'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Role Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a role name.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRole,
                child: const Text('Save Role'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}