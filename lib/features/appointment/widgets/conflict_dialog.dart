import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/appointment_model.dart';
import 'package:appointment_system/core/utils/date_utils.dart';

class ConflictDialog extends StatelessWidget {
  final Appointment conflictingAppointment;

  const ConflictDialog({super.key, required this.conflictingAppointment});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Appointment Conflict Detected'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            const Text('The selected time slot conflicts with an existing appointment:'),
            const SizedBox(height: 10),
            Text(
              'Title: ${conflictingAppointment.title}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Description: ${conflictingAppointment.description}'),
            Text(
                'Time: ${DateUtil.formatDateTime(conflictingAppointment.startTime)} - ${DateUtil.formatTime(conflictingAppointment.endTime)}'),
            const SizedBox(height: 20),
            const Text('Please choose a different time slot.'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}