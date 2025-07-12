import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/slot_model.dart';

class AvailabilityProvider with ChangeNotifier {
  List<Slot> _availabilitySlots = [];
  bool _isLoading = false;

  List<Slot> get availabilitySlots => _availabilitySlots;
  bool get isLoading => _isLoading;

  Future<void> fetchAvailabilitySlots() async {
    _isLoading = true;
    notifyListeners();

    // Simulate fetching data from a backend
    await Future.delayed(const Duration(seconds: 1));
    _availabilitySlots = [
      Slot(
        id: 'slot1',
        startTime: DateTime.now().add(const Duration(days: 1, hours: 9)),
        endTime: DateTime.now().add(const Duration(days: 1, hours: 10)),
        isBooked: false,
        companyId: 'comp1',
      ),
      Slot(
        id: 'slot2',
        startTime: DateTime.now().add(const Duration(days: 1, hours: 10)),
        endTime: DateTime.now().add(const Duration(days: 1, hours: 11)),
        isBooked: true,
        companyId: 'comp1',
      ),
      Slot(
        id: 'slot3',
        startTime: DateTime.now().add(const Duration(days: 2, hours: 14)),
        endTime: DateTime.now().add(const Duration(days: 2, hours: 15)),
        isBooked: false,
        companyId: 'comp1',
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addAvailabilitySlot(Slot newSlot) async {
    _isLoading = true;
    notifyListeners();

    // Simulate adding data to a backend
    await Future.delayed(const Duration(milliseconds: 500));
    _availabilitySlots.add(newSlot);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateAvailabilitySlot(Slot updatedSlot) async {
    _isLoading = true;
    notifyListeners();

    // Simulate updating data on a backend
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _availabilitySlots.indexWhere((slot) => slot.id == updatedSlot.id);
    if (index != -1) {
      _availabilitySlots[index] = updatedSlot;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteAvailabilitySlot(String slotId) async {
    _isLoading = true;
    notifyListeners();

    // Simulate deleting data from a backend
    await Future.delayed(const Duration(milliseconds: 500));
    _availabilitySlots.removeWhere((slot) => slot.id == slotId);

    _isLoading = false;
    notifyListeners();
  }
}