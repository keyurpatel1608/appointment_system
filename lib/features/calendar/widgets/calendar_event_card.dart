import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/appointment_model.dart';
import 'package:appointment_system/core/utils/date_utils.dart';

class CalendarEventCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onTap;

  const CalendarEventCard({
    super.key,
    required this.appointment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        onTap: onTap,
        title: Text(appointment.title),
        subtitle: Text(
          '${DateUtil.formatTime(appointment.startTime)} - ${DateUtil.formatTime(appointment.endTime)} \n' +
          'Status: ${appointment.status.toString().split('.').last}',
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}