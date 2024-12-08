// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/transcription_provider.dart';
import 'providers/summary_provider.dart';
import 'pages/home_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TranscriptionProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => SummaryProvider()..initialize()),
        // Add other providers here
      ],
      child: AudioSummarizerApp(),
    ),
  );
}

class AudioSummarizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Summarizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
