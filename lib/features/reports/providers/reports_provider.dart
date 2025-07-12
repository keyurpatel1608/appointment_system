import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/appointment_model.dart';
import 'package:appointment_system/core/models/user_model.dart';

class ReportsProvider with ChangeNotifier {
  bool _isLoading = false;
  List<Appointment> _appointmentsReport = [];
  List<User> _usersReport = [];

  bool get isLoading => _isLoading;
  List<Appointment> get appointmentsReport => _appointmentsReport;
  List<User> get usersReport => _usersReport;

  Future<void> fetchAppointmentsReport() async {
    _isLoading = true;
    notifyListeners();
    // Simulate fetching data
    await Future.delayed(const Duration(seconds: 1));
    _appointmentsReport = [
      // Dummy data for appointments report
      Appointment(
        id: 'rpt_appt1',
        title: 'Reported Meeting 1',
        description: 'Description for reported meeting 1.',
        startTime: DateTime.now().subtract(const Duration(days: 5, hours: 2)),
        endTime: DateTime.now().subtract(const Duration(days: 5, hours: 1)),
        targetUserId: 'user_rpt1',
        companyId: 'company123',
        status: AppointmentStatus.completed,
      ),
      Appointment(
        id: 'rpt_appt2',
        title: 'Reported Meeting 2',
        description: 'Description for reported meeting 2.',
        startTime: DateTime.now().subtract(const Duration(days: 3, hours: 4)),
        endTime: DateTime.now().subtract(const Duration(days: 3, hours: 3)),
        targetUserId: 'user_rpt2',
        companyId: 'company123',
        status: AppointmentStatus.cancelled,
      ),
    ];
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUsersReport() async {
    _isLoading = true;
    notifyListeners();
    // Simulate fetching data
    await Future.delayed(const Duration(seconds: 1));
    _usersReport = [
      // Dummy data for users report
      User(
        id: 'rpt_user1',
        email: 'report.user1@example.com',
        displayName: 'Report User One',
        role: UserRole.employee,
        companyId: 'company123',
        status: UserStatus.active,
      ),
      User(
        id: 'rpt_user2',
        email: 'report.user2@example.com',
        displayName: 'Report User Two',
        role: UserRole.customer,
        companyId: 'company123',
        status: UserStatus.inactive,
      ),
    ];
    _isLoading = false;
    notifyListeners();
  }

  // Add methods for other types of reports as needed
}