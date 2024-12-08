// lib/services/transcription_service.dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TranscriptionService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadAndTranscribe(File audioFile) async {
    try {
      // Upload to Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.wav';
      Reference ref = _storage.ref().child('audio/$fileName');
      UploadTask uploadTask = ref.putFile(audioFile);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save reference in Firestore to trigger Cloud Function
      await _firestore.collection('audio').doc(fileName).set({
        'storagePath': 'gs://${ref.bucket}/${ref.fullPath}',
        'uploadedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error uploading audio: $e');
    }
  }

  Stream<String?> getTranscription(String audioId) {
    return _firestore
        .collection('transcriptions')
        .doc(audioId)
        .snapshots()
        .map((snap) => snap.data()?['transcription'] as String?);
  }
}
