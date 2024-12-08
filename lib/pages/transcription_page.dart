// lib/pages/transcription_page.dart
import 'package:flutter/material.dart';
import '../models/audio_file.dart';
import '../services/transcription_service.dart';

class TranscriptionPage extends StatefulWidget {
  final AudioFile audioFile;

  const TranscriptionPage({Key? key, required this.audioFile}) : super(key: key);

  @override
  _TranscriptionPageState createState() => _TranscriptionPageState();
}

class _TranscriptionPageState extends State<TranscriptionPage> {
  final TranscriptionService _transcriptionService = TranscriptionService();
  String? _transcription;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTranscription();
  }

  Future<void> _fetchTranscription() async {
    // Replace 'audioId' with the actual identifier for your audio file
    String audioId = widget.audioFile.name;
    _transcriptionService.getTranscription(audioId).listen((transcription) {
      if (transcription != null) {
        setState(() {
          _transcription = transcription;
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Transcription'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _transcription != null
                  ? SingleChildScrollView(
                      child: Text(
                        _transcription!,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : Center(child: Text('No transcription available.')),
        ));
  }
}
