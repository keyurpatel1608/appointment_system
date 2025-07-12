import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/user_provider.dart';
import 'package:appointment_system/core/models/user_model.dart';
import 'package:appointment_system/core/utils/validators.dart';
import 'package:appointment_system/config/routes/app_router.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedRole;
  String? _selectedStatus;

  @override
  void dispose() {
    _emailController.dispose();
    _displayNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _addUser() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedRole == null || _selectedStatus == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a role and status.')),
        );
        return;
      }

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      try {
        final newUser = User(
          id: null, // Firestore will generate this
          email: _emailController.text,
          displayName: _displayNameController.text,
          role: _selectedRole!,
          status: _selectedStatus!,
          companyId: 'company123', // This should be dynamically set based on the logged-in user's company
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await userProvider.addUser(newUser, _passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User added successfully!')), 
        );
        AppRouter.router.pop(); // Go back to user list
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add user: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New User'),
      ),
      body: Padding(
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
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: Validators.validatePassword,
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
                onPressed: _addUser,
                child: const Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}