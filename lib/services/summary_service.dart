// lib/services/summary_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class SummaryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<String?> getSummary(String transcriptionId) {
    return _firestore
        .collection('summaries')
        .doc(transcriptionId)
        .snapshots()
        .map((snap) => snap.data()?['summary'] as String?);
  }
}
