// lib/widgets/transcription_view.dart
import 'package:flutter/material.dart';

class TranscriptionView extends StatelessWidget {
  final String transcription;

  TranscriptionView({required this.transcription});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          transcription,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

