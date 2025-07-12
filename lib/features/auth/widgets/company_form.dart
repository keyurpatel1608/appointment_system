import 'package:flutter/material.dart';
import 'package:appointment_system/core/utils/validators.dart';

class CompanyForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController companyNameController;
  final TextEditingController industryController;
  final String submitButtonText;
  final VoidCallback onSubmit;

  const CompanyForm({
    super.key,
    required this.formKey,
    required this.companyNameController,
    required this.industryController,
    required this.submitButtonText,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: companyNameController,
            decoration: const InputDecoration(
              labelText: 'Company Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) => Validators.validateEmpty(value, 'Company Name'),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: industryController,
            decoration: const InputDecoration(
              labelText: 'Industry',
              border: OutlineInputBorder(),
            ),
            validator: (value) => Validators.validateEmpty(value, 'Industry'),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text(submitButtonText),
          ),
        ],
      ),
    );
  }
}