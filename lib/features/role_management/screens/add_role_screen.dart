import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/role_provider.dart';
import 'package:appointment_system/core/models/role_model.dart';
import 'package:appointment_system/core/utils/validators.dart';
import 'package:appointment_system/config/routes/app_router.dart';

class AddRoleScreen extends StatefulWidget {
  const AddRoleScreen({super.key});

  @override
  State<AddRoleScreen> createState() => _AddRoleScreenState();
}

class _AddRoleScreenState extends State<AddRoleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addRole() async {
    if (_formKey.currentState!.validate()) {
      final roleProvider = Provider.of<RoleProvider>(context, listen: false);
      try {
        final newRole = Role(
          id: null, // Firestore will generate this
          name: _nameController.text,
          description: _descriptionController.text,
          companyId: 'company123', // This should be dynamically set based on the logged-in user's company
          permissions: [], // Permissions will be managed separately
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await roleProvider.addRole(newRole);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Role added successfully!')), 
        );
        AppRouter.router.pop(); // Go back to role list
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add role: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Role'),
      ),
      body: Padding(
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
                onPressed: _addRole,
                child: const Text('Add Role'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}