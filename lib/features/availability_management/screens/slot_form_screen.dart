import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/models/slot_model.dart';
import 'package:appointment_system/features/availability_management/providers/availability_provider.dart';
import 'package:appointment_system/core/utils/date_utils.dart';

class SlotFormScreen extends StatefulWidget {
  final Slot? slot;

  const SlotFormScreen({super.key, this.slot});

  @override
  State<SlotFormScreen> createState() => _SlotFormScreenState();
}

class _SlotFormScreenState extends State<SlotFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _startTime;
  late DateTime _endTime;
  late bool _isBooked;

  @override
  void initState() {
    super.initState();
    _startTime = widget.slot?.startTime ?? DateTime.now();
    _endTime = widget.slot?.endTime ?? DateTime.now().add(const Duration(hours: 1));
    _isBooked = widget.slot?.isBooked ?? false;
  }

  Future<void> _selectDateTime(BuildContext context, bool isStartTime) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartTime ? _startTime : _endTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(isStartTime ? _startTime : _endTime),
      );
      if (pickedTime != null) {
        setState(() {
          final selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          if (isStartTime) {
            _startTime = selectedDateTime;
          } else {
            _endTime = selectedDateTime;
          }
        });
      }
    }
  }

  void _saveSlot() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_endTime.isBefore(_startTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('End time cannot be before start time.')),
        );
        return;
      }

      final availabilityProvider = Provider.of<AvailabilityProvider>(context, listen: false);

      if (widget.slot == null) {
        // Add new slot
        final newSlot = Slot(
          id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
          startTime: _startTime,
          endTime: _endTime,
          isBooked: _isBooked,
          companyId: 'company123', // Placeholder
        );
        availabilityProvider.addAvailabilitySlot(newSlot);
      } else {
        // Update existing slot
        final updatedSlot = widget.slot!.copyWith(
          startTime: _startTime,
          endTime: _endTime,
          isBooked: _isBooked,
        );
        availabilityProvider.updateAvailabilitySlot(updatedSlot);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.slot == null ? 'Add Slot' : 'Edit Slot'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ListTile(
                title: Text('Start Time: ${DateUtil.formatDateTime(_startTime)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDateTime(context, true),
              ),
              ListTile(
                title: Text('End Time: ${DateUtil.formatDateTime(_endTime)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDateTime(context, false),
              ),
              SwitchListTile(
                title: const Text('Is Booked'),
                value: _isBooked,
                onChanged: (bool value) {
                  setState(() {
                    _isBooked = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveSlot,
                child: const Text('Save Slot'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}