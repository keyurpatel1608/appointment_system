import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/appointment_provider.dart';
import 'package:appointment_system/core/models/appointment_model.dart';
import 'package:appointment_system/core/utils/app_utils.dart';
import 'package:appointment_system/core/utils/date_utils.dart' as app_date_utils;

class RescheduleScreen extends StatefulWidget {
  final Appointment appointment;

  const RescheduleScreen({super.key, required this.appointment});

  @override
  State<RescheduleScreen> createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends State<RescheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _selectedDate;
  late TimeOfDay _selectedStartTime;
  late TimeOfDay _selectedEndTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.appointment.startTime;
    _selectedStartTime = TimeOfDay.fromDateTime(widget.appointment.startTime);
    _selectedEndTime = TimeOfDay.fromDateTime(widget.appointment.endTime);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
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
      initialTime: isStartTime ? _selectedStartTime : _selectedEndTime,
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

  Future<void> _rescheduleAppointment() async {
    if (_formKey.currentState!.validate()) {
      final DateTime newStartDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedStartTime.hour,
        _selectedStartTime.minute,
      );
      final DateTime newEndDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedEndTime.hour,
        _selectedEndTime.minute,
      );

      if (newEndDateTime.isBefore(newStartDateTime)) {
        AppUtils.showSnackBar(context, 'End time cannot be before start time.');
        return;
      }

      final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);
      try {
        final updatedAppointment = widget.appointment.copyWith(
          startTime: newStartDateTime,
          endTime: newEndDateTime,
          updatedAt: DateTime.now(),
        );
        await appointmentProvider.updateAppointment(updatedAppointment);
        AppUtils.showSnackBar(context, 'Appointment rescheduled successfully!');
        Navigator.of(context).pop(); // Go back to previous screen
      } catch (e) {
        AppUtils.showSnackBar(context, 'Failed to reschedule appointment: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reschedule Appointment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Appointment: ${widget.appointment.title}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text('Date: ${app_date_utils.DateUtils.formatDate(_selectedDate)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              ListTile(
                title: Text('Start Time: ${_selectedStartTime.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectTime(context, true),
              ),
              ListTile(
                title: Text('End Time: ${_selectedEndTime.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectTime(context, false),
              ),
              const SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: _rescheduleAppointment,
                  child: const Text('Reschedule'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}