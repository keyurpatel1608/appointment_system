import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/utils/validators.dart';
import 'package:appointment_system/core/providers/user_provider.dart';
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
  final TextEditingController _companyIdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isCompanyIdRequired = true;

  // Validation methods
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _displayNameController.dispose();
    _companyIdController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _createCeo() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      try {
        await Future.delayed(const Duration(seconds: 2)); // Simulate API call

        // Example method call (uncomment when implemented):
        // await userProvider.createCeo(
        //   email: _emailController.text,
        //   displayName: _displayNameController.text,
        //   companyId: _companyIdController.text.isNotEmpty ? _companyIdController.text : null,
        //   phone: _phoneController.text,
        //   password: _passwordController.text,
        // );

        if (mounted) {
          AppUtils.showSnackBar(context, 'CEO created successfully!');
          Navigator.of(
            context,
          ).pushReplacementNamed(RouteConstants.dashboardRoute);
        }
      } catch (e) {
        if (mounted) {
          AppUtils.showSnackBar(
            context,
            'CEO creation failed: ${e.toString()}',
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create CEO Account'), elevation: 0),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(Icons.person_add, size: 64, color: Colors.blue),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Create CEO Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32.0),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'CEO Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 16.0),

                    // Display Name Field
                    TextFormField(
                      controller: _displayNameController,
                      decoration: const InputDecoration(
                        labelText: 'Display Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) =>
                          _validateRequired(value, 'Display Name'),
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 16.0),

                    // Phone Field
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          _validateRequired(value, 'Phone Number'),
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 16.0),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                      validator: _validatePassword,
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 16.0),

                    // Company ID Field with Toggle
                    Row(
                      children: [
                        Checkbox(
                          value: _isCompanyIdRequired,
                          onChanged: _isLoading
                              ? null
                              : (value) {
                                  setState(() {
                                    _isCompanyIdRequired = value ?? false;
                                    if (!_isCompanyIdRequired) {
                                      _companyIdController.clear();
                                    }
                                  });
                                },
                        ),
                        const Text('Link to existing company'),
                      ],
                    ),
                    if (_isCompanyIdRequired) ...[
                      const SizedBox(height: 8.0),
                      TextFormField(
                        controller: _companyIdController,
                        decoration: const InputDecoration(
                          labelText: 'Company ID',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.business),
                          helperText: 'Enter existing company ID to link',
                        ),
                        validator: _isCompanyIdRequired
                            ? (value) => _validateRequired(value, 'Company ID')
                            : null,
                        enabled: !_isLoading,
                      ),
                    ],
                    const SizedBox(height: 32.0),

                    // Create Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _createCeo,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'Create CEO',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
