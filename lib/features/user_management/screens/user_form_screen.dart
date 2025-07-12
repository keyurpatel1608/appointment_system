import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/models/user_model.dart';
import 'package:appointment_system/core/providers/user_provider.dart';

class UserFormScreen extends StatefulWidget {
  final User? user;

  const UserFormScreen({super.key, this.user});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _displayNameController;
  late TextEditingController _passwordController;
  late UserRole _selectedRole;
  late UserStatus _selectedStatus;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _displayNameController = TextEditingController(text: widget.user?.displayName ?? '');
    _passwordController = TextEditingController(); // Password is not pre-filled for security
    _selectedRole = widget.user?.role ?? UserRole.customer;
    _selectedStatus = widget.user?.status ?? UserStatus.active;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _displayNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveUser() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      if (widget.user == null) {
        // Add new user
        final newUser = User(
          id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
          email: _emailController.text,
          displayName: _displayNameController.text,
          role: _selectedRole,
          companyId: 'company123', // Placeholder
          status: _selectedStatus,
        );
        userProvider.addUser(newUser);
      } else {
        // Update existing user
        final updatedUser = widget.user!.copyWith(
          email: _emailController.text,
          displayName: _displayNameController.text,
          role: _selectedRole,
          status: _selectedStatus,
        );
        userProvider.updateUser(updatedUser);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Add User' : 'Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Please enter a valid email.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _displayNameController,
                decoration: const InputDecoration(labelText: 'Display Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a display name.';
                  }
                  return null;
                },
              ),
              if (widget.user == null) // Only show password field for new users
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters long.';
                    }
                    return null;
                  },
                ),
              DropdownButtonFormField<UserRole>(
                value: _selectedRole,
                decoration: const InputDecoration(labelText: 'Role'),
                items: UserRole.values.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role.toString().split('.').last.toUpperCase()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
              ),
              DropdownButtonFormField<UserStatus>(
                value: _selectedStatus,
                decoration: const InputDecoration(labelText: 'Status'),
                items: UserStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.toString().split('.').last.toUpperCase()),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedStatus = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUser,
                child: const Text('Save User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}