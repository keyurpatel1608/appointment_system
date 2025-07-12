import 'package:flutter/material.dart';
import 'package:appointment_system/core/utils/validators.dart';
import 'package:appointment_system/core/utils/date_utils.dart' as AppDateUtils;

class AppointmentForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController targetUserIdController;
  final DateTime? initialDate;
  final TimeOfDay? initialStartTime;
  final TimeOfDay? initialEndTime;
  final Function(DateTime?, TimeOfDay?, TimeOfDay?) onDateTimeChanged;
  final String submitButtonText;
  final VoidCallback onSubmit;

  const AppointmentForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.targetUserIdController,
    this.initialDate,
    this.initialStartTime,
    this.initialEndTime,
    required this.onDateTimeChanged,
    required this.submitButtonText,
    required this.onSubmit,
  });

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _selectedStartTime = widget.initialStartTime;
    _selectedEndTime = widget.initialEndTime;
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
      widget.onDateTimeChanged(
        _selectedDate,
        _selectedStartTime,
        _selectedEndTime,
      );
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? (_selectedStartTime ?? TimeOfDay.now())
          : (_selectedEndTime ?? TimeOfDay.now()),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _selectedStartTime = picked;
        } else {
          _selectedEndTime = picked;
        }
      });
      widget.onDateTimeChanged(
        _selectedDate,
        _selectedStartTime,
        _selectedEndTime,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: widget.titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            validator: (value) => Validators.emptyValidator(value, 'Title'),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: widget.descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: (value) =>
                Validators.emptyValidator(value, 'Description'),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: widget.targetUserIdController,
            decoration: const InputDecoration(
              labelText: 'Target User ID (e.g., Employee ID)',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                Validators.emptyValidator(value, 'Target User ID'),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            title: Text(
              _selectedDate == null
                  ? 'Select Date'
                  : 'Date: ${AppDateUtils.DateUtils.formatDate(_selectedDate!)}',
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () => _selectDate(context),
          ),
          ListTile(
            title: Text(
              _selectedStartTime == null
                  ? 'Select Start Time'
                  : 'Start Time: ${_selectedStartTime!.format(context)}',
            ),
            trailing: const Icon(Icons.access_time),
            onTap: () => _selectTime(context, true),
          ),
          ListTile(
            title: Text(
              _selectedEndTime == null
                  ? 'Select End Time'
                  : 'End Time: ${_selectedEndTime!.format(context)}',
            ),
            trailing: const Icon(Icons.access_time),
            onTap: () => _selectTime(context, false),
          ),
          const SizedBox(height: 24.0),
          Center(
            child: ElevatedButton(
              onPressed: widget.onSubmit,
              child: Text(widget.submitButtonText),
            ),
          ),
        ],
      ),
    );
  }
}
