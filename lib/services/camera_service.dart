// lib/services/camera_service.dart
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:smartfiber/helper/camera_permissions_helper.dart';

class CameraService {
  static final CameraService _instance = CameraService._internal();
  factory CameraService() => _instance;
  CameraService._internal();

  List<CameraDescription>? _cameras;
  CameraController? _controller;
  bool _isInitialized = false;
  bool _isRecording = false;

  Future<void> initialize() async {
    try {
      if (!await CameraPermissionsHelper.cameraGranted) {
        final granted = await CameraPermissionsHelper.requestCameraPermission();
        if (!granted) {
          throw Exception('Camera permission denied');
        }
      }

      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        throw Exception('No cameras available');
      }

      final hasCamera = await availableCameras();
      if (hasCamera.isEmpty) throw Exception('No camera available on device');

      _cameras = hasCamera;

      // Initialize with back camera by default
      await _initCameraController(_cameras!.first);
      _isInitialized = true;
    } catch (e) {
      debugPrint('CameraService initialization error: $e');
      _isInitialized = false;
      rethrow;
    }
  }

  Future<void> _initCameraController(CameraDescription camera) async {
    try {
      if (_controller != null) {
        await _controller!.dispose();
      }

      _controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: true,
      );

      await _controller!.initialize().then((_) {
        if (!_controller!.value.isInitialized) {
          throw Exception('Failed to initialize camera controller');
        }
      });
    } catch (e) {
      debugPrint('Camera controller init error: $e');
      rethrow;
    }
  }

  Future<void> switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) return;

    final currentIndex = _cameras!.indexOf(_controller!.description);
    final newIndex = (currentIndex + 1) % _cameras!.length;
    await _initCameraController(_cameras![newIndex]);
  }

  Future<String> takePicture() async {
    if (!_isInitialized || _controller == null) {
      throw Exception('Camera not initialized');
    }

    final image = await _controller!.takePicture();
    return image.path;
  }

  Future<void> startRecording() async {
    if (!_isInitialized || _controller == null || _isRecording) return;

    await _controller!.startVideoRecording();
    _isRecording = true;
  }

  Future<String> stopRecording() async {
    if (!_isRecording || _controller == null) {
      throw Exception('Not currently recording');
    }

    final video = await _controller!.stopVideoRecording();
    _isRecording = false;
    return video.path;
  }

  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
    _isInitialized = false;
    _isRecording = false;
  }

  CameraController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isRecording => _isRecording;
  List<CameraDescription>? get cameras => _cameras;
}
