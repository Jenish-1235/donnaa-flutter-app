
// lib/widgets/summary_view.dart
import 'package:flutter/material.dart';

class SummaryView extends StatelessWidget {
  final String summary;

  SummaryView({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          summary,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}