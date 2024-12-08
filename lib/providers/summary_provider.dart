// lib/providers/summary_provider.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/summary.dart';

class SummaryProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<Summary> _summaries = [];
  StreamSubscription? _summarySubscription;

  List<Summary> get summaries => List.unmodifiable(_summaries);

  // Initialize the provider by setting up listeners
  void initialize() {
    _listenToSummaries();
  }

  // Listen to summaries collection in Firestore
  void _listenToSummaries() {
    _summarySubscription = _firestore
        .collection('summaries')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      _summaries.clear();
      for (var doc in snapshot.docs) {
        _summaries.add(Summary.fromDocument(doc));
      }
      notifyListeners();
    }, onError: (error) {
      print('Error listening to summaries: $error');
    });
  }

  // Fetch summary for a specific transcription
  Stream<Summary?> getSummaryByTranscriptionId(String transcriptionId) {
    return _firestore
        .collection('summaries')
        .where('transcriptionId', isEqualTo: transcriptionId)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            return Summary.fromDocument(snapshot.docs.first);
          }
          return null;
        });
  }

  // Dispose the subscription when provider is disposed
  @override
  void dispose() {
    _summarySubscription?.cancel();
    super.dispose();
  }
}
