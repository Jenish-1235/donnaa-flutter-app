
// lib/pages/summary_page.dart
import 'package:flutter/material.dart';
import '../models/audio_file.dart';
import '../services/summary_service.dart';

class SummaryPage extends StatefulWidget {
  final AudioFile audioFile;

  const SummaryPage({Key? key, required this.audioFile}) : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final SummaryService _summaryService = SummaryService();
  String? _summary;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSummary();
  }

  Future<void> _fetchSummary() async {
    // Replace 'transcriptionId' with the actual identifier for your transcription
    String transcriptionId = widget.audioFile.name;
    _summaryService.getSummary(transcriptionId).listen((summary) {
      if (summary != null) {
        setState(() {
          _summary = summary;
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Summary'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _summary != null
                  ? SingleChildScrollView(
                      child: Text(
                        _summary!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Center(child: Text('No summary available.')),
        ));
  }
}
