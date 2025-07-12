import 'package:flutter/material.dart';
import 'package:appointment_system/core/utils/validators.dart';

class RoleForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final String submitButtonText;
  final VoidCallback onSubmit;

  const RoleForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
    required this.submitButtonText,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Role Name'),
            validator: (value) => Validators.validateEmpty(value, 'Role Name'),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3,
            validator: (value) => Validators.validateEmpty(value, 'Description'),
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