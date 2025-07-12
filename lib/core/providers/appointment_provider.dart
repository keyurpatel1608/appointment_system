import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/appointment_model.dart';
import 'package:appointment_system/core/services/firestore_service.dart';

class AppointmentProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Appointment> _appointments = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Placeholder methods for user and company IDs
  String getCurrentUserId() {
    // In a real app, this would come from an authentication service
    return 'user123'; // Dummy user ID
  }

  String getSelectedTargetUserId() {
    // In a real app, this would come from user selection in the form
    return 'targetUser456'; // Dummy target user ID
  }

  String getCurrentCompanyId() {
    // In a real app, this would come from the current user's company context
    return 'company789'; // Dummy company ID
  }

  List<Appointment> get appointments => _appointments;

  Future<void> fetchAppointments() async {
    _isLoading = true;
    notifyListeners();
    // In a real app, filter by user, company, date, etc.
    _appointments = await _firestoreService.streamCollection<Appointment>('appointments', Appointment.fromJson).first;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addAppointment(Appointment appointment) async {
    await _firestoreService.addDocument('appointments', appointment.toJson());
    await fetchAppointments();
  }

  Future<void> updateAppointment(Appointment appointment) async {
    await _firestoreService.updateDocument('appointments', appointment.id!, appointment.toJson());
    await fetchAppointments();
  }

  Future<void> deleteAppointment(String appointmentId) async {
    await _firestoreService.deleteDocument('appointments', appointmentId);
    await fetchAppointments();
  }
}