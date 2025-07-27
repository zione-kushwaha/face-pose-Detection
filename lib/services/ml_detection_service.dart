import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../models/detection_result.dart';

class MLDetectionService {
  PoseDetector? _poseDetector;
  FaceDetector? _faceDetector;
  bool _isDetecting = false;
  int _frameSkipCounter = 0;

  bool get isDetecting => _isDetecting;

  void initializePoseDetector() {
    final options = PoseDetectorOptions(
      model: PoseDetectionModel.base, // Using base model for better performance
      mode: PoseDetectionMode.stream,
    );
    _poseDetector = PoseDetector(options: options);
  }

  void initializeFaceDetector() {
    final options = FaceDetectorOptions(
      enableClassification: false, // Disabled for performance
      enableLandmarks: true,
      enableContours: true,
      enableTracking: true,
    );
    _faceDetector = FaceDetector(options: options);
  }

  Future<DetectionResult?> processImage(
    CameraImage cameraImage,
    int sensorOrientation,
  ) async {
    if (_isDetecting || _poseDetector == null || _faceDetector == null)
      return null;

    // Implement frame skipping for better performance
    _frameSkipCounter++;
    if (_frameSkipCounter % 3 != 0) {
      return null; // Skip this frame
    }

    _isDetecting = true;

    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in cameraImage.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize = Size(
        cameraImage.width.toDouble(),
        cameraImage.height.toDouble(),
      );

      final imageRotation = InputImageRotationValue.fromRawValue(
        sensorOrientation,
      );
      if (imageRotation == null) return null;

      final inputImageFormat = InputImageFormatValue.fromRawValue(
        cameraImage.format.raw,
      );
      if (inputImageFormat == null) return null;

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: imageSize,
          rotation: imageRotation,
          format: inputImageFormat,
          bytesPerRow: cameraImage.planes[0].bytesPerRow,
        ),
      );

      // Process both pose and face detection
      final poses = await _poseDetector!.processImage(inputImage);
      final faces = await _faceDetector!.processImage(inputImage);

      return DetectionResult(poses: poses, faces: faces);
    } catch (e) {
      print('Error processing image: $e');
      return null;
    } finally {
      _isDetecting = false;
    }
  }

  void dispose() {
    _poseDetector?.close();
    _faceDetector?.close();
  }
}

class DetectionResult {
  final List<Pose> poses;
  final List<Face> faces;

  DetectionResult({required this.poses, required this.faces});
}
