// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transcription_provider.dart';
import '../providers/summary_provider.dart';
import '../widgets/audio_list.dart';
import '../services/file_service.dart';
import '../models/audio_file.dart';
import '../services/transcription_service.dart';

class HomePage extends StatelessWidget {
  final FileService _fileService = FileService();
  final TranscriptionService _transcriptionService = TranscriptionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Summarizer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Button to select audio file
            ElevatedButton(
              onPressed: () async {
                File? selectedFile = await _fileService.pickAudioFile();
                if (selectedFile != null) {
                  // Save the file locally
                  File savedFile = await _fileService.saveFile(selectedFile);
                  // Upload and transcribe
                  await _transcriptionService.uploadAndTranscribe(savedFile);
                }
              },
              child: Text('Select and Transcribe Audio'),
            ),
            SizedBox(height: 20),
            // Display the list of audio files
            Expanded(
              child: AudioList(),
            ),
          ],
        ),
      ),
    );
  }
}
