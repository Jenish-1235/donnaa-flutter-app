// lib/models/summary.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Summary {
  final String id;
  final String transcriptionId;
  final String summaryText;
  final DateTime createdAt;

  Summary({
    required this.id,
    required this.transcriptionId,
    required this.summaryText,
    required this.createdAt,
  });

  // Factory constructor to create a Summary instance from Firestore document
  factory Summary.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Summary(
      id: doc.id,
      transcriptionId: data['transcriptionId'] ?? '',
      summaryText: data['summary'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert Summary instance to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'transcriptionId': transcriptionId,
      'summary': summaryText,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
