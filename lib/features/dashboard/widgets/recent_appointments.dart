import 'package:flutter/material.dart';

class RecentAppointments extends StatelessWidget {
  const RecentAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Recent Appointments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // TODO: Replace with actual list of appointments
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Meeting with John Doe'),
              subtitle: const Text('Today, 10:00 AM - 11:00 AM'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle tap
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Project Review'),
              subtitle: const Text('Tomorrow, 02:00 PM - 03:00 PM'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle tap
              },
            ),
            // Add more appointment items as needed
          ],
        ),
      ),
    );
  }
}