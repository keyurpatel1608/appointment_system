import 'package:flutter/material.dart';

class ReportChart extends StatelessWidget {
  final String title;
  final Widget? chartContent; // Placeholder for actual chart widget

  const ReportChart({
    super.key,
    required this.title,
    this.chartContent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Placeholder for the actual chart library widget
            Container(
              height: 200,
              color: Colors.grey[200],
              child: Center(
                child: chartContent ?? const Text('Chart will be displayed here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}