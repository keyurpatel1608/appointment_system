import 'package:flutter/material.dart' hide DateUtils;
import 'package:appointment_system/core/utils/date_utils.dart';

class TimeSlotPicker extends StatefulWidget {
  final DateTime selectedDate;
  final Function(TimeOfDay?, TimeOfDay?) onTimeSlotSelected;
  final TimeOfDay? initialStartTime;
  final TimeOfDay? initialEndTime;

  const TimeSlotPicker({
    super.key,
    required this.selectedDate,
    required this.onTimeSlotSelected,
    this.initialStartTime,
    this.initialEndTime,
  });

  @override
  State<TimeSlotPicker> createState() => _TimeSlotPickerState();
}

class _TimeSlotPickerState extends State<TimeSlotPicker> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  @override
  void initState() {
    super.initState();
    _startTime = widget.initialStartTime;
    _endTime = widget.initialEndTime;
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? (_startTime ?? TimeOfDay.now())
          : (_endTime ?? TimeOfDay.now()),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
      widget.onTimeSlotSelected(_startTime, _endTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Selected Date: ${DateUtils.formatDate(widget.selectedDate)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListTile(
          title: Text(
            _startTime == null
                ? 'Select Start Time'
                : 'Start Time: ${_startTime!.format(context)}',
          ),
          trailing: const Icon(Icons.access_time),
          onTap: () => _selectTime(context, true),
        ),
        ListTile(
          title: Text(
            _endTime == null
                ? 'Select End Time'
                : 'End Time: ${_endTime!.format(context)}',
          ),
          trailing: const Icon(Icons.access_time),
          onTap: () => _selectTime(context, false),
        ),
        if (_startTime != null &&
            _endTime != null &&
            _endTime!.hour < _startTime!.hour) // Basic validation
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'End time cannot be before start time.',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
