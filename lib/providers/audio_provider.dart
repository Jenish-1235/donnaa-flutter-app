// lib/providers/audio_provider.dart
import 'package:flutter/material.dart';
import '../models/audio_file.dart';
import '../services/file_service.dart';

class AudioProvider with ChangeNotifier {
  final FileService _fileService = FileService();
  List<AudioFile> _audioFiles = [];

  List<AudioFile> get audioFiles => _audioFiles;

  AudioProvider() {
    loadAudioFiles();
  }

  Future<void> loadAudioFiles() async {
    List<AudioFile> _audioFiles = await _fileService.getAllAudioFiles();
    notifyListeners();
  }

  Future<void> addAudioFile(AudioFile audioFile) async {
    _audioFiles.add(audioFile);
    notifyListeners();
  }

  Future<void> removeAudioFile(String filePath) async {
    _audioFiles.removeWhere((file) => file.path == filePath);
    notifyListeners();
  }
}
