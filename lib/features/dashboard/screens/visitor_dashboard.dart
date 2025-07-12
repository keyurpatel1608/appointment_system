import 'package:flutter/material.dart';

class VisitorDashboard extends StatelessWidget {
  const VisitorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor Dashboard'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome, Visitor!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Here you can view public information or book appointments.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            // TODO: Add options for public viewing or appointment booking
          ],
        ),
      ),
    );
  }
}