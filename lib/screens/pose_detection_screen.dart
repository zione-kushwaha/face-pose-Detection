import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../main.dart';
import '../services/camera_service.dart';
import '../services/ml_detection_service.dart';
import '../widgets/pose_and_face_painter.dart';

class PoseDetectionScreen extends StatefulWidget {
  const PoseDetectionScreen({super.key});

  @override
  State<PoseDetectionScreen> createState() => _PoseDetectionScreenState();
}

class _PoseDetectionScreenState extends State<PoseDetectionScreen> {
  final CameraService _cameraService = CameraService();
  final MLDetectionService _mlService = MLDetectionService();

  DetectionResult? _lastDetectionResult;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    // Initialize ML detectors
    _mlService.initializePoseDetector();
    _mlService.initializeFaceDetector();

    // Initialize camera
    final success = await _cameraService.initializeCamera(cameras);

    if (success && mounted) {
      setState(() {
        _isInitialized = true;
      });

      // Start image stream for detection
      _cameraService.startImageStream(_processCameraImage);
    } else if (mounted) {
      setState(() {});
    }
  }

  Future<void> _processCameraImage(CameraImage cameraImage) async {
    if (_cameraService.selectedCamera == null) return;

    final result = await _mlService.processImage(
      cameraImage,
      _cameraService.selectedCamera!.sensorOrientation,
    );

    if (result != null && mounted) {
      setState(() {
        _lastDetectionResult = result;
        _cameraService.updateStatus(
          'Detected ${result.poses.length} pose(s), ${result.faces.length} face(s)',
        );
      });
    }
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _mlService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isInitialized && _cameraService.controller != null
          ? Stack(
              children: [
                // Camera preview
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: CameraPreview(_cameraService.controller!),
                ),
                // Pose and Face overlay
                if (_lastDetectionResult != null)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: PoseAndFacePainter(
                        _lastDetectionResult!.poses,
                        _lastDetectionResult!.faces,
                        _cameraService.controller!.value.previewSize!,
                        isFrontCamera:
                            _cameraService.selectedCamera?.lensDirection ==
                            CameraLensDirection.front,
                      ),
                    ),
                  ),
                // Status text
                Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _cameraService.statusMessage,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text(
                    _cameraService.statusMessage,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
