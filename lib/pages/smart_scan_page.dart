import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:custom_ratio_camera/custom_ratio_camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  Future<void> takePicture() async {
    int randomSeconds = math.Random().nextInt(10);

    final cameraProvider = Provider.of<CameraProvider>(context, listen: false);

    setState(() {
      loadingImage = true;
    });

    final String _imagePath = await cameraProvider.takePicture();

// final int randomSeconds = math.Random().nextInt(10);

    // await Future.delayed(Duration(seconds:randomSeconds ));

    setState(() {
      imageFile = File(_imagePath);

      imagePath = _imagePath;

      tookAPicture = true;
      loadingImage = false;
    });

    log(randomSeconds.toString());
    await Future.delayed(Duration(seconds: randomSeconds));

    final LaravelId laravelId = context.read<LaravelId>();

    final Prediction prediction = await getImagePrediction(laravelId.id!);

    cameraProvider.dispose();

    if (mounted) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => ScanResultPage(
                    imagePath: imageFile,
                    prediction: prediction,
                  )));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final cameraProvider = context.read<CameraProvider>();
      await cameraProvider.ensureInitialized();
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final cameraProvider = Provider.of<CameraProvider>(context);

    if (cameraProvider.error != null) {
      return Scaffold(
        body: Center(
          child: Text("Error: ${cameraProvider.error}"),
        ),
      );
    }

    log((cameraProvider.controller == null).toString());

    if (cameraProvider.isLoading || cameraProvider.controller == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Scan"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.large(
        onPressed: takePicture,
        child: Column(
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
                        ? SizedBox(
                            height: 8 * 4,
                            width: 8 * 4,
                            child: CircularProgressIndicator(),
                          )
                        : Hero(
                            tag: imageFile!.path,
                            child: Image.file(
                              imageFile!,
                              fit: BoxFit.cover,
                            )),
                  ),
                )
              : CustomRatioCameraPreview(
                  cameraController: cameraProvider.controller!,
                  expectedRatio: 1.0, // 1:1 aspect ratio
                ),
          Align(
            alignment: Alignment.topLeft,
            child: Card(
              color: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "BETA",
                  style: TextStyle(
                      fontSize: 8 * 2,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
          tookAPicture ? CameraScanningAnimationOverlay() : SizedBox()
        ],
      ),
    );
  }
}
