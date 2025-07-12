import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/appointment_model.dart';
import 'package:appointment_system/core/utils/date_utils.dart'
    as CustomDateUtils;

class AppointmentDetailScreen extends StatelessWidget {
  final Appointment appointment;

  const AppointmentDetailScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appointment Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              appointment.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(appointment.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            _buildDetailRow(
              Icons.calendar_today,
              'Date',
              CustomDateUtils.DateUtils.formatDate(appointment.startTime),
            ),
            _buildDetailRow(
              Icons.access_time,
              'Time',
              '${CustomDateUtils.DateUtils.formatTime(appointment.startTime)} - ${CustomDateUtils.DateUtils.formatTime(appointment.endTime)}',
            ),
            _buildDetailRow(
              Icons.person,
              'User',
              appointment.userId,
            ), // This would ideally show user's name
            _buildDetailRow(
              Icons.person_outline,
              'Target User',
              appointment.targetUserId,
            ), // This would ideally show target user's name
            _buildDetailRow(
              Icons.business,
              'Company ID',
              appointment.companyId,
            ),
            _buildDetailRow(
              Icons.info_outline,
              'Status',
              appointment.status.toString().split('.').last,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement reschedule logic
                    debugPrint('Reschedule appointment');
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Reschedule'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement cancel/delete logic
                    debugPrint('Cancel appointment');
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancel'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.grey[600]),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
