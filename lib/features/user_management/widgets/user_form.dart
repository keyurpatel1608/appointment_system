import 'package:flutter/material.dart';
import 'package:appointment_system/core/utils/validators.dart';

class UserForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController displayNameController;
  final TextEditingController? passwordController;
  final String? initialRole;
  final String? initialStatus;
  final Function(String?) onRoleChanged;
  final Function(String?) onStatusChanged;
  final String submitButtonText;
  final VoidCallback onSubmit;
  final bool isEditing;

  const UserForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.displayNameController,
    this.passwordController,
    this.initialRole,
    this.initialStatus,
    required this.onRoleChanged,
    required this.onStatusChanged,
    required this.submitButtonText,
    required this.onSubmit,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: Validators.validateEmail,
            keyboardType: TextInputType.emailAddress,
            enabled: !isEditing, // Email usually not editable after creation
          ),
          TextFormField(
            controller: displayNameController,
            decoration: const InputDecoration(labelText: 'Display Name'),
            validator: (value) => Validators.validateEmpty(value, 'Display Name'),
          ),
          if (!isEditing) // Password only needed for new user creation
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: Validators.validatePassword,
            ),
          DropdownButtonFormField<String>(
            value: initialRole,
            decoration: const InputDecoration(labelText: 'Role'),
            items: <String>['Super Admin', 'CEO', 'Manager', 'Employee', 'Visitor']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onRoleChanged,
            validator: (value) => value == null ? 'Please select a role' : null,
          ),
          DropdownButtonFormField<String>(
            value: initialStatus,
            decoration: const InputDecoration(labelText: 'Status'),
            items: <String>['Active', 'Inactive', 'Pending']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onStatusChanged,
            validator: (value) => value == null ? 'Please select a status' : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text(submitButtonText),
          ),
        ],
      ),
    );
  }
}