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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: companyNameController,
              decoration: const InputDecoration(
                labelText: 'Company Name',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
              validator: (value) =>
                  Validators.emptyValidator(value, 'Company Name'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: industryController,
              decoration: const InputDecoration(
                labelText: 'Industry',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
              validator: (value) =>
                  Validators.emptyValidator(value, 'Industry'),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: onSubmit,
                child: Text(
                  submitButtonText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
