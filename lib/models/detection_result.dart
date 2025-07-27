import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class DetectionResult {
  final List<Pose> poses;
  final List<Face> faces;
  final String statusMessage;

  DetectionResult({
    required this.poses,
    required this.faces,
    String? statusMessage,
  }) : statusMessage =
           statusMessage ??
           'Detected ${poses.length} pose(s), ${faces.length} face(s)';
}
