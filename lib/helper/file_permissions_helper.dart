import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class FilePermissionsHelper {
  static Future<bool> requestPhotoLibraryPermission() async {
    final status = await Permission.photos.request();

    // On Android, use storage permission for older versions
    if (status.isDenied && Platform.isAndroid) {
      final storageStatus = await Permission.storage.request();
      return storageStatus.isGranted;
    }

    return status.isGranted;
  }

  /// Check if we have photo library permission
  static Future<bool> hasPhotoLibraryPermission() async {
    if (await Permission.photos.isGranted) return true;
    if (Platform.isAndroid && await Permission.storage.isGranted) return true;
    return false;
  }

  /// Open app settings for user to manually enable permissions
  static Future<void> openAppSettings() async {
    await openAppSettings();
  }

  /// Check current permission status
  static Future<bool> get hasPhotoLibraryAccess async {
    if (Platform.isAndroid) {
      return await Permission.photos.isGranted || await Permission.storage.isGranted;
    }
    return await Permission.photos.isGranted;
  }
}
