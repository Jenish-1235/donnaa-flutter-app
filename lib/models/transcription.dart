// lib/models/transcription.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Transcription {
  final String id;
  final String audioId;
  final String transcriptionText;
  final DateTime createdAt;

  Transcription({
    required this.id,
    required this.audioId,
    required this.transcriptionText,
    required this.createdAt,
  });

  // Factory constructor to create a Transcription instance from Firestore document
  factory Transcription.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Transcription(
      id: doc.id,
      audioId: data['audioId'] ?? '',
      transcriptionText: data['transcription'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert Transcription instance to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'audioId': audioId,
      'transcription': transcriptionText,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
