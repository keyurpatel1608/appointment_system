import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/utils/validators.dart';
import 'package:appointment_system/core/providers/user_provider.dart';
import 'package:appointment_system/core/utils/app_utils.dart';
import 'package:appointment_system/core/constants/route_constants.dart';

class CompanyRegistrationScreen extends StatefulWidget {
  const CompanyRegistrationScreen({super.key});

  @override
  State<CompanyRegistrationScreen> createState() =>
      _CompanyRegistrationScreenState();
}

class _CompanyRegistrationScreenState extends State<CompanyRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _industryController = TextEditingController();

  @override
  void dispose() {
    _companyNameController.dispose();
    _industryController.dispose();
    super.dispose();
  }

  Future<void> _registerCompany() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );

        // Simulate company registration process
        await Future.delayed(const Duration(seconds: 2));

        // Hide loading indicator
        if (mounted) {
          Navigator.of(context).pop();
        }

        // TODO: Implement actual company creation logic
        // final userProvider = Provider.of<UserProvider>(context, listen: false);
        // await userProvider.createCompany(_companyNameController.text, _industryController.text);

        if (mounted) {
          AppUtils.showSnackBar(context, 'Company registration successful!');
          Navigator.of(
            context,
          ).pushReplacementNamed(RouteConstants.dashboardRoute);
        }
      } catch (e) {
        // Hide loading indicator if still showing
        if (mounted) {
          Navigator.of(context).pop();
          AppUtils.showSnackBar(
            context,
            'Company registration failed: ${e.toString()}',
          );
        }
      }
    }
  }

  // Custom validator for empty fields
  String? _validateEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Your Company')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _companyNameController,
                  decoration: const InputDecoration(
                    labelText: 'Company Name',
                    border: OutlineInputBorder(),
                    hintText: 'Enter your company name',
                  ),
                  validator: (value) => _validateEmpty(value, 'Company Name'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _industryController,
                  decoration: const InputDecoration(
                    labelText: 'Industry',
                    border: OutlineInputBorder(),
                    hintText: 'Enter your industry',
                  ),
                  validator: (value) => _validateEmpty(value, 'Industry'),
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _registerCompany,
                    child: const Text('Register Company'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
