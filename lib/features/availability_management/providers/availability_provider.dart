import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/slot_model.dart';

enum AvailabilityState { initial, loading, loaded, error }

class AvailabilityProvider with ChangeNotifier {
  List<Slot> _availabilitySlots = [];
  AvailabilityState _availabilityState = AvailabilityState.initial;
  String? _errorMessage;

  List<Slot> get availabilitySlots => _availabilitySlots;
  AvailabilityState get availabilityState => _availabilityState;
  String? get errorMessage => _errorMessage;

  /// Fetches availability slots from a simulated backend.
  /// Updates the state to loading, then loaded or error.
  Future<void> fetchAvailabilitySlots() async {
    _setAvailabilityState(AvailabilityState.loading);
    try {
      // Simulate fetching data from a backend
      await Future.delayed(const Duration(seconds: 1));
      _availabilitySlots = [
        Slot(
          id: 'slot1',
          userId: 'user1',
          startTime: DateTime.now().add(const Duration(days: 1, hours: 9)),
          endTime: DateTime.now().add(const Duration(days: 1, hours: 10)),
          status: SlotStatus.available,
          companyId: 'comp1',
        ),
        Slot(
          id: 'slot2',
          userId: 'user2',
          startTime: DateTime.now().add(const Duration(days: 1, hours: 10)),
          endTime: DateTime.now().add(const Duration(days: 1, hours: 11)),
          status: SlotStatus.booked,
          companyId: 'comp1',
        ),
        Slot(
          id: 'slot3',
          userId: 'user1',
          startTime: DateTime.now().add(const Duration(days: 2, hours: 14)),
          endTime: DateTime.now().add(const Duration(days: 2, hours: 15)),
          status: SlotStatus.available,
          companyId: 'comp1',
        ),
      ];
      _setAvailabilityState(AvailabilityState.loaded);
    } catch (e) {
      _setAvailabilityState(AvailabilityState.error, message: e.toString());
    }
  }

  /// Adds a new availability slot to the simulated backend.
  /// Updates the state to loading, then loaded or error.
  Future<void> addAvailabilitySlot(Slot newSlot) async {
    _setAvailabilityState(AvailabilityState.loading);
    try {
      // Simulate adding data to a backend
      await Future.delayed(const Duration(milliseconds: 500));
      _availabilitySlots.add(newSlot);
      _setAvailabilityState(AvailabilityState.loaded);
    } catch (e) {
      _setAvailabilityState(AvailabilityState.error, message: e.toString());
    }
  }

  /// Updates an existing availability slot in the simulated backend.
  /// Updates the state to loading, then loaded or error.
  Future<void> updateAvailabilitySlot(Slot updatedSlot) async {
    _setAvailabilityState(AvailabilityState.loading);
    try {
      // Simulate updating data on a backend
      await Future.delayed(const Duration(milliseconds: 500));
      final index = _availabilitySlots.indexWhere(
        (slot) => slot.id == updatedSlot.id,
      );
      if (index != -1) {
        _availabilitySlots[index] = updatedSlot;
      }
      _setAvailabilityState(AvailabilityState.loaded);
    } catch (e) {
      _setAvailabilityState(AvailabilityState.error, message: e.toString());
    }
  }

  /// Deletes an availability slot from the simulated backend.
  /// Updates the state to loading, then loaded or error.
  Future<void> deleteAvailabilitySlot(String slotId) async {
    _setAvailabilityState(AvailabilityState.loading);
    try {
      // Simulate deleting data from a backend
      await Future.delayed(const Duration(milliseconds: 500));
      _availabilitySlots.removeWhere((slot) => slot.id == slotId);
      _setAvailabilityState(AvailabilityState.loaded);
    } catch (e) {
      _setAvailabilityState(AvailabilityState.error, message: e.toString());
    }
  }

  void _setAvailabilityState(AvailabilityState state, {String? message}) {
    _availabilityState = state;
    _errorMessage = message;
    notifyListeners();
  }
}
