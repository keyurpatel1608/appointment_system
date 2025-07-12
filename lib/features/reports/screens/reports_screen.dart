import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Reports will be displayed here.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example: Navigate to a specific report
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Generating Appointment Report...'))
                );
              },
              child: const Text('Generate Appointment Report'),
            ),
            ElevatedButton(
              onPressed: () {
                // Example: Navigate to another specific report
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Generating User Activity Report...'))
                );
              },
              child: const Text('Generate User Activity Report'),
            ),
          ],
        ),
      ),
    );
  }
}