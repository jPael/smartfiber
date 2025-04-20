import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfiber/components/toolbar_button.dart';
import 'package:smartfiber/helper/file_permissions_helper.dart';
import 'package:smartfiber/models/laravel_id.dart';
import 'package:smartfiber/models/prediction.dart';
import 'package:smartfiber/pages/about_us.dart';
import 'package:smartfiber/pages/scan_result_page.dart';
import 'package:smartfiber/pages/smart_scan_page.dart';
import 'package:smartfiber/services/image_picker_service.dart';
import 'package:smartfiber/services/laravel/ai_service.dart';

class Toolbar extends StatefulWidget {
  const Toolbar({super.key});

  @override
  State<Toolbar> createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  final GalleryImagePickerService _galleryService = GalleryImagePickerService();
  File? _selectedImage;
  List<File> _selectedImages = [];
  bool _isLoading = false;

  Future<void> _pickSingleImage() async {
    setState(() => _isLoading = true);
    final int randomSeconds = Random().nextInt(10);
    final File? image = await _galleryService.pickSingleImage();

    final LaravelId laravel = context.read<LaravelId>();

    laravel.setIsLoading(true);

    await Future.delayed(Duration(seconds: randomSeconds));

    final Prediction prediction = await getImagePrediction(laravel.id!);

    if (mounted) {
      laravel.setIsLoading(false);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScanResultPage(
                    imagePath: image!,
                    prediction: prediction,
                  )));
    }

    if (image == null) {
      _showPermissionWarningIfNeeded();
    }
  }

  Future<void> _showPermissionWarningIfNeeded() async {
    final hasAccess = await _galleryService.isGalleryAccessAvailable;
    if (!hasAccess) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Permission Required'),
          content: Text('Please enable photo library access in settings to select images'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Open Settings'),
              onPressed: () {
                Navigator.pop(context);
                FilePermissionsHelper.openAppSettings();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ToolbarButton(
          label: "Smart Scan",
          icon: Icons.camera_rounded,
          ontap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) => SmartScanPage())),
        ),
        ToolbarButton(
          label: "Import Image",
          icon: Icons.image,
          ontap: _pickSingleImage,
        ),
        ToolbarButton(
          label: "About us",
          icon: Icons.info,
          ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs())),
        ),
        // ToolbarButton(
        //   label: "Model info",
        //   icon: Icons.account_tree_rounded,
        //   ontap: () {},
        // ),
        // ToolbarButton(
        //   label: "Accuracy",
        //   icon: Icons.check_circle_outline_rounded,
        //   ontap: () {},
        // ),
      ],
    );
  }
}
