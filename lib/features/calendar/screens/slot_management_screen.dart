import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/appointment_provider.dart'; // To check for existing appointments
import 'package:appointment_system/core/models/slot_model.dart'; // Assuming a Slot model exists
import 'package:appointment_system/core/utils/date_utils.dart';

class SlotManagementScreen extends StatefulWidget {
  const SlotManagementScreen({super.key});

  @override
  State<SlotManagementScreen> createState() => _SlotManagementScreenState();
}

class _SlotManagementScreenState extends State<SlotManagementScreen> {
  final List<Slot> _slots = []; // Example list of managed slots

  @override
  void initState() {
    super.initState();
    _loadSlots();
  }

  void _loadSlots() {
    // In a real app, load slots from a backend service or local storage
    // For now, add some dummy slots
    setState(() {
      _slots.add(Slot(
        id: 'slot1',
        startTime: DateTime.now().add(const Duration(days: 1, hours: 9)),
        endTime: DateTime.now().add(const Duration(days: 1, hours: 10)),
        isBooked: false,
        companyId: 'company123',
      ));
      _slots.add(Slot(
        id: 'slot2',
        startTime: DateTime.now().add(const Duration(days: 1, hours: 10)),
        endTime: DateTime.now().add(const Duration(days: 1, hours: 11)),
        isBooked: true,
        companyId: 'company123',
      ));
    });
  }

  Future<void> _addSlot() async {
    // Implement logic to add a new slot, e.g., show a dialog with date/time pickers
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate == null) return;

    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedStartTime == null) return;

    final TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1),
    );
    if (pickedEndTime == null) return;

    final newStartTime = DateTime(
      pickedDate.year, pickedDate.month, pickedDate.day,
      pickedStartTime.hour, pickedStartTime.minute,
    );
    final newEndTime = DateTime(
      pickedDate.year, pickedDate.month, pickedDate.day,
      pickedEndTime.hour, pickedEndTime.minute,
    );

    if (newEndTime.isBefore(newStartTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End time cannot be before start time.')),
      );
      return;
    }

    // Check for conflicts with existing appointments or slots
    final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);
    final conflicts = appointmentProvider.appointments.where((appt) {
      return (newStartTime.isBefore(appt.endTime) && newEndTime.isAfter(appt.startTime));
    }).toList();

    if (conflicts.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New slot conflicts with an existing appointment!')), 
      );
      return;
    }

    setState(() {
      _slots.add(Slot(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Simple ID generation
        startTime: newStartTime,
        endTime: newEndTime,
        isBooked: false,
        companyId: 'company123',
      ));
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Slot added successfully!')), 
    );
  }

  void _deleteSlot(String id) {
    setState(() {
      _slots.removeWhere((slot) => slot.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Slot deleted successfully!')), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slot Management'),
      ),
      body: _slots.isEmpty
          ? const Center(child: Text('No slots managed yet.'))
          : ListView.builder(
              itemCount: _slots.length,
              itemBuilder: (context, index) {
                final slot = _slots[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                        '${DateUtil.formatDateTime(slot.startTime)} - ${DateUtil.formatTime(slot.endTime)}'),
                    subtitle: Text(slot.isBooked ? 'Booked' : 'Available'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteSlot(slot.id),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSlot,
        child: const Icon(Icons.add),
      ),
    );
  }
}