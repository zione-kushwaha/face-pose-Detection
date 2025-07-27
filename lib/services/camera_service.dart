import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  CameraController? _controller;
  bool _isInitialized = false;
  String _statusMessage = 'Initializing...';
  CameraDescription? _selectedCamera;

  CameraController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  String get statusMessage => _statusMessage;
  CameraDescription? get selectedCamera => _selectedCamera;

  Future<bool> initializeCamera(List<CameraDescription> cameras) async {
    try {
      // Request camera permission
      var status = await Permission.camera.request();
      if (status != PermissionStatus.granted) {
        _statusMessage = 'Camera permission denied';
        return false;
      }

      if (cameras.isEmpty) {
        _statusMessage = 'No cameras available';
        return false;
      }

      // Find front camera (user-facing camera)
      CameraDescription? frontCamera;
      for (final camera in cameras) {
        if (camera.lensDirection == CameraLensDirection.front) {
          frontCamera = camera;
          break;
        }
      }

      // If no front camera found, use the first available camera
      _selectedCamera = frontCamera ?? cameras[0];

      _controller = CameraController(
        _selectedCamera!,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller!.initialize();

      _isInitialized = true;
      _statusMessage =
          _selectedCamera!.lensDirection == CameraLensDirection.front
          ? 'Front camera ready'
          : 'Back camera ready';

      return true;
    } catch (e) {
      _statusMessage = 'Error initializing camera: $e';
      return false;
    }
  }

  void startImageStream(Function(CameraImage) onImageAvailable) {
    _controller?.startImageStream(onImageAvailable);
  }

  void stopImageStream() {
    _controller?.stopImageStream();
  }

  void dispose() {
    _controller?.stopImageStream();
    _controller?.dispose();
  }

  void updateStatus(String message) {
    _statusMessage = message;
  }
}
