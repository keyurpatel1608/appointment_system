import 'package:flutter/material.dart';

class ReportTable extends StatelessWidget {
  final String title;
  final List<List<String>> headers;
  final List<List<String>> data;

  const ReportTable({
    super.key,
    required this.title,
    required this.headers,
    required this.data,
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: headers
                    .map((header) => DataColumn(label: Text(header[0])))
                    .toList(),
                rows: data
                    .map(
                      (row) => DataRow(
                        cells: row
                            .map((cell) => DataCell(Text(cell)))
                            .toList(),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}