// lib/models/audio_file.dart
import 'dart:io';

class AudioFile {
  final String name;
  final String path;
  final DateTime uploadedAt;

  AudioFile({
    required this.name,
    required this.path,
    required this.uploadedAt,
  });

  factory AudioFile.fromFile(File file) {
    return AudioFile(
      name: file.path.split('/').last,
      path: file.path,
      uploadedAt: file.statSync().modified,
    );
  }
}
