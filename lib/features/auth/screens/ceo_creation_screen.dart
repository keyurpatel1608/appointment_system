import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/utils/validators.dart';
import 'package:appointment_system/core/providers/user_provider.dart'; // Assuming UserProvider handles CEO creation for now
import 'package:appointment_system/core/utils/app_utils.dart';
import 'package:appointment_system/core/constants/route_constants.dart';

class CeoCreationScreen extends StatefulWidget {
  const CeoCreationScreen({super.key});

  @override
  State<CeoCreationScreen> createState() => _CeoCreationScreenState();
}

class _CeoCreationScreenState extends State<CeoCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _companyIdController = TextEditingController(); // In a real app, this would likely be selected or derived

  @override
  void dispose() {
    _emailController.dispose();
    _displayNameController.dispose();
    _companyIdController.dispose();
    super.dispose();
  }

  Future<void> _createCeo() async {
    if (_formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      try {
        // This is a simplified example. In a real app, CEO creation would involve more logic
        // like assigning roles and linking to an existing company or creating a new one.
        // await userProvider.createCeo(
        //   _emailController.text,
        //   _displayNameController.text,
        //   _companyIdController.text,
        // );
        AppUtils.showSnackBar(context, 'CEO created successfully!');
        Navigator.of(context).pushReplacementNamed(RouteConstants.dashboardRoute); // Navigate to dashboard after creation
      } catch (e) {
        AppUtils.showSnackBar(context, 'CEO creation failed: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create CEO Account'),
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
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'CEO Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _displayNameController,
                  decoration: const InputDecoration(
                    labelText: 'Display Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => Validators.validateEmpty(value, 'Display Name'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _companyIdController,
                  decoration: const InputDecoration(
                    labelText: 'Company ID (for existing company)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => Validators.validateEmpty(value, 'Company ID'),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: _createCeo,
                  child: const Text('Create CEO'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}