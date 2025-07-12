import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/models/company_model.dart'; // Assuming a Company model exists
import 'package:appointment_system/features/company/providers/company_provider.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current company data or empty strings
    final companyProvider = Provider.of<CompanyProvider>(context, listen: false);
    _nameController = TextEditingController(text: companyProvider.currentCompany?.name ?? '');
    _addressController = TextEditingController(text: companyProvider.currentCompany?.address ?? '');
    _phoneController = TextEditingController(text: companyProvider.currentCompany?.phone ?? '');
    _emailController = TextEditingController(text: companyProvider.currentCompany?.email ?? '');

    // Fetch company data if not already loaded
    if (companyProvider.currentCompany == null) {
      companyProvider.fetchCompanyProfile();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveCompanyProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final companyProvider = Provider.of<CompanyProvider>(context, listen: false);

      final updatedCompany = Company(
        id: companyProvider.currentCompany?.id ?? 'new_company_id', // Handle new company creation
        name: _nameController.text,
        address: _addressController.text,
        phone: _phoneController.text,
        email: _emailController.text,
      );

      try {
        await companyProvider.updateCompanyProfile(updatedCompany);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Company profile updated successfully!')), 
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update company profile: $e')), 
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Profile'),
      ),
      body: Consumer<CompanyProvider>(
        builder: (context, companyProvider, child) {
          if (companyProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (companyProvider.currentCompany == null) {
            return const Center(child: Text('No company profile found.'));
          } else {
            // Update controllers if data changes after initial load
            _nameController.text = companyProvider.currentCompany!.name;
            _addressController.text = companyProvider.currentCompany!.address;
            _phoneController.text = companyProvider.currentCompany!.phone;
            _emailController.text = companyProvider.currentCompany!.email;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Company Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter company name.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'Please enter a valid email.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveCompanyProfile,
                      child: const Text('Save Profile'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}