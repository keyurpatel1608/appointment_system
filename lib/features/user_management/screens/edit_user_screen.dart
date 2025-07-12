import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/user_provider.dart';
import 'package:appointment_system/core/models/user_model.dart';
import 'package:appointment_system/core/utils/validators.dart';
import 'package:appointment_system/config/routes/app_router.dart';

class EditUserScreen extends StatefulWidget {
  final String userId;

  const EditUserScreen({super.key, required this.userId});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  String? _selectedRole;
  String? _selectedStatus;
  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      _currentUser = await userProvider.getUserById(widget.userId);
      if (_currentUser != null) {
        _emailController.text = _currentUser!.email;
        _displayNameController.text = _currentUser!.displayName ?? '';
        _selectedRole = _currentUser!.role;
        _selectedStatus = _currentUser!.status;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateUser() async {
    if (_formKey.currentState!.validate() && _currentUser != null) {
      if (_selectedRole == null || _selectedStatus == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a role and status.')),
        );
        return;
      }

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      try {
        final updatedUser = _currentUser!.copyWith(
          email: _emailController.text,
          displayName: _displayNameController.text,
          role: _selectedRole!,
          status: _selectedStatus!,
          updatedAt: DateTime.now(),
        );
        await userProvider.updateUser(updatedUser);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User updated successfully!')), 
        );
        AppRouter.router.pop(); // Go back to user detail or list
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _currentUser == null
              ? const Center(child: Text('User not found.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: Validators.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(
                          controller: _displayNameController,
                          decoration: const InputDecoration(labelText: 'Display Name'),
                          validator: (value) => Validators.validateEmpty(value, 'Display Name'),
                        ),
                        DropdownButtonFormField<String>(
                          value: _selectedRole,
                          decoration: const InputDecoration(labelText: 'Role'),
                          items: <String>['Super Admin', 'CEO', 'Manager', 'Employee', 'Visitor']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRole = newValue;
                            });
                          },
                          validator: (value) => value == null ? 'Please select a role' : null,
                        ),
                        DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          decoration: const InputDecoration(labelText: 'Status'),
                          items: <String>['Active', 'Inactive', 'Pending']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedStatus = newValue;
                            });
                          },
                          validator: (value) => value == null ? 'Please select a status' : null,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _updateUser,
                          child: const Text('Update User'),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}