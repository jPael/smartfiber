import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartfiber/helper/file_permissions_helper.dart';

class GalleryImagePickerService {
  final ImagePicker _picker = ImagePicker();

  /// Pick single image from gallery
  Future<File?> pickSingleImage({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality = 80,
    bool requestPermission = true,
  }) async {
    try {
      // Check permission if requested
      if (requestPermission) {
        final hasPermission = await FilePermissionsHelper.requestPhotoLibraryPermission();
        if (!hasPermission) {
          debugPrint('Gallery access permission denied');
          return null;
        }
      }

      // Pick image from gallery
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

      return image != null ? File(image.path) : null;
    } catch (e) {
      debugPrint('Image picker error: $e');
      return null;
    }
  }

  /// Pick multiple images from gallery
  Future<List<File>?> pickMultipleImages({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality = 80,
    bool requestPermission = true,
  }) async {
    try {
      // Check permission if requested
      if (requestPermission) {
        final hasPermission = await FilePermissionsHelper.requestPhotoLibraryPermission();
        if (!hasPermission) {
          debugPrint('Gallery access permission denied');
          return null;
        }
      }

      // Pick multiple images
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
      );

      return images.isNotEmpty ? images.map((xFile) => File(xFile.path)).toList() : null;
    } catch (e) {
      debugPrint('Multi image picker error: $e');
      return null;
    }
  }

  /// Check if gallery access is available
  Future<bool> get isGalleryAccessAvailable async {
    return await FilePermissionsHelper.hasPhotoLibraryAccess;
  }
}
