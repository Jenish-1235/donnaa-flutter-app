// lib/services/file_service.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FileService {
  Future<File?> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> saveFile(File file) async {
    final pathDir = await getLocalPath();
    final fileName = path.basename(file.path);
    final newPath = path.join(pathDir, fileName);
    return file.copy(newPath);
  }

  Future<List<File>> getAllAudioFiles() async {
    final pathDir = await getLocalPath();
    final dir = Directory(pathDir);
    List<File> files = [];
    if (await dir.exists()) {
      files = dir
          .listSync()
          .where((item) => item.path.endsWith(".mp3") || item.path.endsWith(".wav"))
          .map((item) => File(item.path))
          .toList();
    }
    return files;
  }
}
