import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/slot_model.dart';
import 'package:appointment_system/core/utils/date_utils.dart';

class SlotEditor extends StatefulWidget {
  final Slot? initialSlot;
  final Function(Slot) onSave;

  const SlotEditor({super.key, this.initialSlot, required this.onSave});

  @override
  State<SlotEditor> createState() => _SlotEditorState();
}

class _SlotEditorState extends State<SlotEditor> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  bool _isBooked = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialSlot != null) {
      _selectedDate = widget.initialSlot!.startTime;
      _selectedStartTime = TimeOfDay.fromDateTime(widget.initialSlot!.startTime);
      _selectedEndTime = TimeOfDay.fromDateTime(widget.initialSlot!.endTime);
      _isBooked = widget.initialSlot!.isBooked;
    } else {
      _selectedDate = DateTime.now();
      _selectedStartTime = TimeOfDay.now();
      _selectedEndTime = TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? (_selectedStartTime ?? TimeOfDay.now()) : (_selectedEndTime ?? TimeOfDay.now()),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _selectedStartTime = picked;
        } else {
          _selectedEndTime = picked;
        }
      });
    }
  }

  void _saveSlot() {
    if (_selectedDate == null || _selectedStartTime == null || _selectedEndTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date and time.')),
      );
      return;
    }

    final startTime = DateTime(
      _selectedDate!.year, _selectedDate!.month, _selectedDate!.day,
      _selectedStartTime!.hour, _selectedStartTime!.minute,
    );
    final endTime = DateTime(
      _selectedDate!.year, _selectedDate!.month, _selectedDate!.day,
      _selectedEndTime!.hour, _selectedEndTime!.minute,
    );

    if (endTime.isBefore(startTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End time cannot be before start time.')),
      );
      return;
    }

    final newSlot = Slot(
      id: widget.initialSlot?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      startTime: startTime,
      endTime: endTime,
      isBooked: _isBooked,
      companyId: widget.initialSlot?.companyId ?? 'company123', // Placeholder
    );
    widget.onSave(newSlot);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialSlot == null ? 'Add New Slot' : 'Edit Slot'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(_selectedDate == null
                  ? 'Select Date'
                  : 'Date: ${DateUtil.formatDate(_selectedDate!)}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            ListTile(
              title: Text(_selectedStartTime == null
                  ? 'Select Start Time'
                  : 'Start Time: ${_selectedStartTime!.format(context)}'),
              trailing: const Icon(Icons.access_time),
              onTap: () => _selectTime(context, true),
            ),
            ListTile(
              title: Text(_selectedEndTime == null
                  ? 'Select End Time'
                  : 'End Time: ${_selectedEndTime!.format(context)}'),
              trailing: const Icon(Icons.access_time),
              onTap: () => _selectTime(context, false),
            ),
            Row(
              children: [
                const Text('Is Booked:'),
                Switch(
                  value: _isBooked,
                  onChanged: (value) {
                    setState(() {
                      _isBooked = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          onPressed: _saveSlot,
          child: const Text('Save'),
        ),
      ],
    );
  }
}