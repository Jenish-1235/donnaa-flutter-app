// lib/services/permission_service.dart
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  Future<bool> requestBluetoothPermission() async {
    var status = await Permission.bluetooth.status;
    if (!status.isGranted) {
      status = await Permission.bluetooth.request();
    }
    return status.isGranted;
  }

  Future<bool> requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }
    return status.isGranted;
  }
}
