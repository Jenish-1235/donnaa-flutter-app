// lib/providers/transcription_provider.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transcription.dart';

class TranscriptionProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Transcription> _transcriptions = [];
  StreamSubscription? _transcriptionSubscription;

  List<Transcription> get transcriptions => List.unmodifiable(_transcriptions);

  // Initialize the provider by setting up listeners
  void initialize() {
    _listenToTranscriptions();
  }

  // Listen to transcriptions collection in Firestore
  void _listenToTranscriptions() {
    _transcriptionSubscription = _firestore
        .collection('transcriptions')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      _transcriptions.clear();
      for (var doc in snapshot.docs) {
        _transcriptions.add(Transcription.fromDocument(doc));
      }
      notifyListeners();
    }, onError: (error) {
      print('Error listening to transcriptions: $error');
    });
  }

  // Fetch transcriptions for a specific audio file
  Stream<List<Transcription>> getTranscriptionsByAudioId(String audioId) {
    return _firestore
        .collection('transcriptions')
        .where('audioId', isEqualTo: audioId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Transcription.fromDocument(doc)).toList());
  }

  // Dispose the subscription when provider is disposed
  @override
  void dispose() {
    _transcriptionSubscription?.cancel();
    super.dispose();
  }
}
