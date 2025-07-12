import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/company_model.dart';

class CompanyProvider with ChangeNotifier {
  Company? _currentCompany;
  bool _isLoading = false;

  Company? get currentCompany => _currentCompany;
  bool get isLoading => _isLoading;

  Future<void> fetchCompanyProfile() async {
    _isLoading = true;
    notifyListeners();

    // Simulate fetching data from a backend
    await Future.delayed(const Duration(seconds: 1));
    _currentCompany = Company(
      id: 'comp1',
      name: 'Appointment Pro Inc.',
      address: '123 Business Rd, Suite 100, City, State, 12345',
      phone: '555-123-4567',
      email: 'info@appointmentpro.com',
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateCompanyProfile(Company updatedCompany) async {
    _isLoading = true;
    notifyListeners();

    // Simulate updating data on a backend
    await Future.delayed(const Duration(seconds: 1));
    _currentCompany = updatedCompany;

    _isLoading = false;
    notifyListeners();
  }
}