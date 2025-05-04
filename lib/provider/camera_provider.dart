// lib/providers/camera_provider.dart
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../services/camera_service.dart';

class CameraProvider with ChangeNotifier {
  final CameraService _cameraService = CameraService();
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  CameraController? get controller => _cameraService.controller;
  bool get isRecording => _cameraService.isRecording;

  Future<void> ensureInitialized() async {
    if (_cameraService.isInitialized) return;
    await initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _cameraService.initialize();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> takePicture() async {
    return await _cameraService.takePicture();
  }

  Future<void> switchCamera() async {
    await _cameraService.switchCamera();
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _cameraService.dispose();
  }
}
