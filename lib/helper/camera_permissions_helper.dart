import 'package:permission_handler/permission_handler.dart';

class CameraPermissionsHelper {
  static Future<bool> get cameraGranted async {
    final status = await Permission.camera.status;
    return status.isGranted;
  }

  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }
}
