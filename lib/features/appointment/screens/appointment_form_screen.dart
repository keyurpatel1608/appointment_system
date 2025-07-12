// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/models/appointment_model.dart';
import 'package:appointment_system/core/providers/appointment_provider.dart';

class AppointmentFormScreen extends StatefulWidget {
  final Appointment? appointment;

  const AppointmentFormScreen({super.key, this.appointment});

  @override
  State<AppointmentFormScreen> createState() => _AppointmentFormScreenState();
}

class _AppointmentFormScreenState extends State<AppointmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _startTime;
  late DateTime _endTime;
  late AppointmentStatus _status;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.appointment?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.appointment?.description ?? '',
    );
    _startTime = widget.appointment?.startTime ?? DateTime.now();
    _endTime =
        widget.appointment?.endTime ??
        DateTime.now().add(const Duration(hours: 1));
    // Fixed: Use correct enum constant (assuming it's 'pending' or another available value)
    _status = widget.appointment?.status ?? AppointmentStatus.pending;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
        initialTime: TimeOfDay.fromDateTime(
          isStartTime ? _startTime : _endTime,
        ),
      );
      if (pickedTime != null && mounted) {
        // Fixed: Added mounted check
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

  void _saveAppointment() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_endTime.isBefore(_startTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('End time cannot be before start time.'),
          ),
        );
        return;
      }

      final appointmentProvider = Provider.of<AppointmentProvider>(
        context,
        listen: false,
      );

      if (widget.appointment == null) {
        // Add new appointment
        // TODO: Get these values from the current user session/database
        final currentUserId = appointmentProvider
            .getCurrentUserId(); // Should get from auth/session
        final targetUserId = appointmentProvider
            .getSelectedTargetUserId(); // Should get from form or selection
        final companyId = appointmentProvider
            .getCurrentCompanyId(); // Should get from auth/session

        final newAppointment = Appointment(
          id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
          title: _titleController.text,
          description: _descriptionController.text,
          startTime: _startTime,
          endTime: _endTime,
          userId: currentUserId,
          targetUserId: targetUserId,
          companyId: companyId,
          status: _status,
        );
        appointmentProvider.addAppointment(newAppointment);
      } else {
        // Update existing appointment - using manual property assignment instead of copyWith
        final updatedAppointment = Appointment(
          id: widget.appointment!.id,
          title: _titleController.text,
          description: _descriptionController.text,
          startTime: _startTime,
          endTime: _endTime,
          userId: widget.appointment!.userId, // Keep original userId
          targetUserId:
              widget.appointment!.targetUserId, // Keep original targetUserId
          companyId: widget.appointment!.companyId, // Keep original companyId
          status: _status,
        );
        appointmentProvider.updateAppointment(updatedAppointment);
      }
      Navigator.of(context).pop();
    }
  }

  // Helper method to format DateTime since DateUtil is not available
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appointment == null ? 'Add Appointment' : 'Edit Appointment',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              ListTile(
                title: Text(
                  'Start Time: ${_formatDateTime(_startTime)}',
                ), // Fixed: Using local method
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDateTime(context, true),
              ),
              ListTile(
                title: Text(
                  'End Time: ${_formatDateTime(_endTime)}',
                ), // Fixed: Using local method
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDateTime(context, false),
              ),
              DropdownButtonFormField<AppointmentStatus>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: AppointmentStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(
                      status.toString().split('.').last.toUpperCase(),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAppointment,
                child: const Text('Save Appointment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
