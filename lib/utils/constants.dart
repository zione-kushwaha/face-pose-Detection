// App Constants
class AppConstants {
  // Performance Settings
  static const int frameSkipRate = 3; // Process every 3rd frame
  static const double maxMeshConnectionDistance = 80.0;
  static const int simplifiedGridHorizontalLines = 4;
  static const int simplifiedGridVerticalLines = 3;

  // Visual Effect Settings
  static const double reducedBlurRadius = 2.0;
  static const double reducedStrokeWidth = 1.5;
  static const double eyeEffectRadius = 20.0;

  // Status Messages
  static const String initializing = 'Initializing...';
  static const String cameraPermissionDenied = 'Camera permission denied';
  static const String noCamerasAvailable = 'No cameras available';
  static const String frontCameraReady = 'Front camera ready';
  static const String backCameraReady = 'Back camera ready';

  static String detectionStatus(int poses, int faces) {
    return 'Detected $poses pose(s), $faces face(s)';
  }

  static String cameraError(String error) {
    return 'Error initializing camera: $error';
  }
}
