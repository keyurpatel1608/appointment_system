import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/appointment_model.dart';
import 'package:appointment_system/core/models/slot_model.dart';

class CalendarProvider with ChangeNotifier {
  List<Appointment> _appointments = [];
  List<Slot> _slots = [];
  bool _isLoading = false;

  List<Appointment> get appointments => _appointments;
  List<Slot> get slots => _slots;
  bool get isLoading => _isLoading;

  // Method to fetch appointments (e.g., from a service)
  Future<void> fetchAppointments() async {
    _isLoading = true;
    notifyListeners();
    // Simulate fetching data
    await Future.delayed(const Duration(seconds: 1));
    _appointments = [
      // Dummy data
      Appointment(
        id: 'appt1',
        title: 'Meeting with Client A',
        description: 'Discuss project requirements.',
        startTime: DateTime.now().add(const Duration(hours: 2)),
        endTime: DateTime.now().add(const Duration(hours: 3)),
        targetUserId: 'user123',
        companyId: 'company123',
        status: AppointmentStatus.scheduled,
      ),
      Appointment(
        id: 'appt2',
        title: 'Team Sync',
        description: 'Weekly team synchronization meeting.',
        startTime: DateTime.now().add(const Duration(days: 1, hours: 10)),
        endTime: DateTime.now().add(const Duration(days: 1, hours: 11)),
        targetUserId: 'user456',
        companyId: 'company123',
        status: AppointmentStatus.scheduled,
      ),
    ];
    _isLoading = false;
    notifyListeners();
  }

  // Method to fetch slots
  Future<void> fetchSlots() async {
    _isLoading = true;
    notifyListeners();
    // Simulate fetching data
    await Future.delayed(const Duration(seconds: 1));
    _slots = [
      // Dummy data
      Slot(
        id: 'slot1',
        startTime: DateTime.now().add(const Duration(hours: 9)),
        endTime: DateTime.now().add(const Duration(hours: 10)),
        isBooked: false,
        companyId: 'company123',
      ),
      Slot(
        id: 'slot2',
        startTime: DateTime.now().add(const Duration(hours: 10)),
        endTime: DateTime.now().add(const Duration(hours: 11)),
        isBooked: true,
        companyId: 'company123',
      ),
    ];
    _isLoading = false;
    notifyListeners();
  }

  // Add, update, delete methods for appointments and slots would go here
  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  void updateAppointment(Appointment updatedAppointment) {
    _appointments = _appointments.map((appt) =>
        appt.id == updatedAppointment.id ? updatedAppointment : appt).toList();
    notifyListeners();
  }

  void deleteAppointment(String id) {
    _appointments.removeWhere((appt) => appt.id == id);
    notifyListeners();
  }

  void addSlot(Slot slot) {
    _slots.add(slot);
    notifyListeners();
  }

  void updateSlot(Slot updatedSlot) {
    _slots = _slots.map((s) =>
        s.id == updatedSlot.id ? updatedSlot : s).toList();
    notifyListeners();
  }

  void deleteSlot(String id) {
    _slots.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}