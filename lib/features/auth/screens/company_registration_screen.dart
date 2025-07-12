import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/utils/validators.dart';
import 'package:appointment_system/core/providers/user_provider.dart'; // Assuming UserProvider handles company creation for now
import 'package:appointment_system/core/utils/app_utils.dart';
import 'package:appointment_system/core/constants/route_constants.dart';

class CompanyRegistrationScreen extends StatefulWidget {
  const CompanyRegistrationScreen({super.key});

  @override
  State<CompanyRegistrationScreen> createState() => _CompanyRegistrationScreenState();
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
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      try {
        // This is a simplified example. In a real app, company creation would be more complex.
        // It might involve a dedicated CompanyProvider or a service.
        // For now, we'll simulate it by just showing a success message.
        // await userProvider.createCompany(_companyNameController.text, _industryController.text);
        AppUtils.showSnackBar(context, 'Company registration successful!');
        Navigator.of(context).pushReplacementNamed(RouteConstants.dashboardRoute); // Navigate to dashboard after registration
      } catch (e) {
        AppUtils.showSnackBar(context, 'Company registration failed: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Your Company'),
      ),
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
                  ),
                  validator: (value) => Validators.validateEmpty(value, 'Company Name'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _industryController,
                  decoration: const InputDecoration(
                    labelText: 'Industry',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => Validators.validateEmpty(value, 'Industry'),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _registerCompany,
                  child: const Text('Register Company'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}