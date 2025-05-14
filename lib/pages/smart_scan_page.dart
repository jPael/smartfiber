import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:custom_ratio_camera/custom_ratio_camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfiber/components/alert/alert.dart';
import 'package:smartfiber/components/button/custom_button.dart';
import 'package:smartfiber/components/camera/camera_scanning_animation_overlay.dart';
import 'package:smartfiber/models/laravel_id.dart';
import 'package:smartfiber/models/prediction.dart';
import 'package:smartfiber/pages/scan_result_page.dart';
import 'package:smartfiber/provider/camera_provider.dart';
import 'package:smartfiber/services/laravel/ai_service.dart';

class SmartScanPage extends StatefulWidget {
  const SmartScanPage({super.key});

  @override
  State<SmartScanPage> createState() => _SmartScanPageState();
}

class _SmartScanPageState extends State<SmartScanPage> {
  bool tookAPicture = false;
  bool loadingImage = false;
  String? imagePath;
  File? imageFile;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey();
  late final CameraProvider _cameraProvider; // Store provider reference

  void showErrorALert() {
    Alert.showErrorMessage(message: "Can't predict image");
  }

  Future<void> takePicture() async {
    setState(() {
      loadingImage = true;
    });

    final String imagePath = await _cameraProvider.takePicture();

    setState(() {
      imageFile = File(imagePath);
      tookAPicture = true;
      loadingImage = false;
    });

    final LaravelId laravelId = context.read<LaravelId>();
    final Prediction? prediction =
        await getImagePrediction(userId: laravelId.id!, imageFile: imageFile!);

    if (prediction == null) {
      showErrorALert();

      setState(() {
        tookAPicture = false;
      });

      Navigator.pop(context);
      return;
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ScanResultPage(
            imagePath: imageFile,
            prediction: prediction,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _cameraProvider = context.read<CameraProvider>(); // Initialize here

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _cameraProvider.ensureInitialized();
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    // _cameraProvider.(); // Use stored reference
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraProvider.error != null) {
      return Scaffold(
        body: Center(
          child: Text("Error: ${_cameraProvider.error}"),
        ),
      );
    }

    log((_cameraProvider.controller == null).toString());

    if (_cameraProvider.isLoading || _cameraProvider.controller == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Scan"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.large(
        onPressed: takePicture,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.camera),
            Text("Scan"),
          ],
        ),
      ),
      body: Stack(
        children: [
          tookAPicture
              ? Align(
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: loadingImage
                        ? const SizedBox(
                            height: 32,
                            width: 32,
                            child: CircularProgressIndicator(),
                          )
                        : Hero(
                            tag: imageFile!.path,
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                )
              : CustomRatioCameraPreview(
                  cameraController: _cameraProvider.controller!,
                  expectedRatio: 1.0,
                ),
          Align(
            alignment: Alignment.topLeft,
            child: Card(
              color: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "BETA",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
          tookAPicture ? const CameraScanningAnimationOverlay() : const SizedBox(),
        ],
      ),
    );
  }
}
