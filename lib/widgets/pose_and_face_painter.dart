import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../utils/coordinate_translator.dart';
import '../utils/pose_connections.dart';

class PoseAndFacePainter extends CustomPainter {
  final List<Pose> poses;
  final List<Face> faces;
  final Size previewSize;
  final bool isFrontCamera;
  final CoordinateTranslator _translator;

  PoseAndFacePainter(
    this.poses,
    this.faces,
    this.previewSize, {
    this.isFrontCamera = true,
  }) : _translator = CoordinateTranslator(previewSize, isFrontCamera);

  @override
  void paint(Canvas canvas, Size size) {
    // Enhanced pose painting with glow effects
    _drawPoses(canvas, size);

    // Cool face masks and effects
    _drawFaceMasks(canvas, size);
  }

  void _drawPoses(Canvas canvas, Size size) {
    // Create powerful muscular effect for pose landmarks
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..strokeWidth = 12.0
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8.0);

    final glowPaint = Paint()
      ..color = Colors.red.withOpacity(0.8)
      ..strokeWidth = 8.0
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5.0);

    final corePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 6.0
      ..style = PaintingStyle.fill;

    // Enhanced muscular line paint with multiple layers
    final shadowLinePaint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..strokeWidth =
          8.0 // Reduced from 12.0 for performance
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.outer,
        4.0,
      ); // Reduced blur

    final glowLinePaint = Paint()
      ..color = Colors.red.withOpacity(0.6)
      ..strokeWidth =
          5.0 // Reduced from 8.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.outer,
        2.0,
      ); // Reduced blur

    final coreLinePaint = Paint()
      ..color = Colors.red
      ..strokeWidth =
          3.0 // Reduced from 5.0
      ..style = PaintingStyle.stroke;

    final innerLinePaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..strokeWidth =
          1.5 // Reduced from 2.0
      ..style = PaintingStyle.stroke;

    for (final pose in poses) {
      // Draw muscular pose landmarks with multiple layers
      for (final landmark in pose.landmarks.values) {
        final point = _translator.translatePoint(landmark.x, landmark.y, size);
        canvas.drawCircle(point, 8, shadowPaint); // Reduced from 10
        canvas.drawCircle(point, 6, glowPaint); // Reduced from 8
        canvas.drawCircle(point, 4, corePaint); // Reduced from 6
        canvas.drawCircle(
          point,
          2, // Reduced from 3
          Paint()..color = Colors.white.withOpacity(0.9),
        );
      }

      // Draw muscular pose connections with layered effect
      _drawMuscularConnections(
        canvas,
        pose,
        size,
        shadowLinePaint,
        glowLinePaint,
        coreLinePaint,
        innerLinePaint,
      );
    }
  }

  void _drawFaceMasks(Canvas canvas, Size size) {
    for (final face in faces) {
      // Draw geometric wireframe face mesh
      _drawGeometricFaceMesh(canvas, face, size);
      // Draw villainous face effects
      _drawVillainEyes(canvas, face, size);
      _drawDarkFaceOutline(canvas, face, size);
      _drawMenacingMouth(canvas, face, size);
      _drawVillainMark(canvas, face, size);
    }
  }

  void _drawGeometricFaceMesh(Canvas canvas, Face face, Size size) {
    // Create geometric wireframe mesh paint
    final meshPaint = Paint()
      ..color = Colors.cyan.withOpacity(0.8)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final glowMeshPaint = Paint()
      ..color = Colors.cyan.withOpacity(0.3)
      ..strokeWidth =
          2.5 // Reduced from 3.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.outer,
        1.5,
      ); // Reduced blur

    final vertexPaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    // Get key facial landmarks and reduce complexity
    final landmarks = face.landmarks;
    final keyPoints = <Offset>[];

    // Only add essential landmarks for performance
    final essentialLandmarks = [
      FaceLandmarkType.leftEye,
      FaceLandmarkType.rightEye,
      FaceLandmarkType.noseBase,
      FaceLandmarkType.bottomMouth,
      FaceLandmarkType.leftCheek,
      FaceLandmarkType.rightCheek,
    ];

    for (final landmarkType in essentialLandmarks) {
      final landmark = landmarks[landmarkType];
      if (landmark != null) {
        keyPoints.add(
          _translator.translatePoint(
            landmark.position.x.toDouble(),
            landmark.position.y.toDouble(),
            size,
          ),
        );
      }
    }

    // Draw simplified triangular mesh connections
    _drawSimplifiedTriangularMesh(canvas, keyPoints, glowMeshPaint, meshPaint);

    // Draw vertices
    for (final point in keyPoints) {
      canvas.drawCircle(point, 1.5, vertexPaint); // Reduced from 2
    }

    // Draw simplified face grid
    _drawSimplifiedFaceGrid(canvas, face, size);
  }

  void _drawSimplifiedTriangularMesh(
    Canvas canvas,
    List<Offset> points,
    Paint glowPaint,
    Paint corePaint,
  ) {
    if (points.length < 3) return;

    // Create triangular connections between points with reduced complexity
    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        final distance = (points[i] - points[j]).distance;

        // Only connect nearby points and reduce distance threshold
        if (distance < 80) {
          // Reduced from 100
          canvas.drawLine(points[i], points[j], glowPaint);
          canvas.drawLine(points[i], points[j], corePaint);
        }
      }
    }
  }

  void _drawSimplifiedFaceGrid(Canvas canvas, Face face, Size size) {
    final gridPaint = Paint()
      ..color = Colors.green
          .withOpacity(0.3) // Reduced opacity
      ..strokeWidth =
          0.8 // Reduced from 1.0
      ..style = PaintingStyle.stroke;

    final rect = _translator.translateRect(face.boundingBox, size);

    // Draw simplified grid (4x3 instead of 8x6)
    final gridSpacing = rect.height / 4;
    for (int i = 1; i < 4; i++) {
      final y = rect.top + (gridSpacing * i);
      canvas.drawLine(Offset(rect.left, y), Offset(rect.right, y), gridPaint);
    }

    final vGridSpacing = rect.width / 3;
    for (int i = 1; i < 3; i++) {
      final x = rect.left + (vGridSpacing * i);
      canvas.drawLine(Offset(x, rect.top), Offset(x, rect.bottom), gridPaint);
    }
  }

  void _drawVillainEyes(Canvas canvas, Face face, Size size) {
    final leftEye = face.landmarks[FaceLandmarkType.leftEye];
    final rightEye = face.landmarks[FaceLandmarkType.rightEye];

    // Simplified eye effects for performance
    final darkAuraPaint = Paint()
      ..color = Colors.black
          .withOpacity(0.6) // Reduced opacity
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.outer,
        8.0,
      ); // Reduced blur

    final redGlowPaint = Paint()
      ..color = Colors.red
          .withOpacity(0.7) // Reduced opacity
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.outer,
        5.0,
      ); // Reduced blur

    final eyeCorePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final innerEyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final geometricRingPaint = Paint()
      ..color = Colors.cyan
      ..strokeWidth =
          1.5 // Reduced from 2.0
      ..style = PaintingStyle.stroke;

    void drawEyeEffect(Offset eyePoint) {
      // Reduced effect layers for performance
      canvas.drawCircle(eyePoint, 20, darkAuraPaint); // Reduced from 25
      canvas.drawCircle(eyePoint, 15, redGlowPaint); // Reduced from 18
      canvas.drawCircle(eyePoint, 10, eyeCorePaint); // Reduced from 12
      canvas.drawCircle(eyePoint, 5, innerEyePaint); // Reduced from 6

      // Simplified geometric rings
      canvas.drawCircle(eyePoint, 16, geometricRingPaint); // Reduced from 20
      canvas.drawCircle(eyePoint, 12, geometricRingPaint); // Reduced from 15

      // Simplified crosshairs
      canvas.drawLine(
        Offset(eyePoint.dx - 20, eyePoint.dy), // Reduced from 25
        Offset(eyePoint.dx + 20, eyePoint.dy),
        geometricRingPaint,
      );
      canvas.drawLine(
        Offset(eyePoint.dx, eyePoint.dy - 20),
        Offset(eyePoint.dx, eyePoint.dy + 20),
        geometricRingPaint,
      );
    }

    if (leftEye != null) {
      final leftEyePoint = _translator.translatePoint(
        leftEye.position.x.toDouble(),
        leftEye.position.y.toDouble(),
        size,
      );
      drawEyeEffect(leftEyePoint);
    }

    if (rightEye != null) {
      final rightEyePoint = _translator.translatePoint(
        rightEye.position.x.toDouble(),
        rightEye.position.y.toDouble(),
        size,
      );
      drawEyeEffect(rightEyePoint);
    }
  }

  void _drawDarkFaceOutline(Canvas canvas, Face face, Size size) {
    final darkOutlinePaint = Paint()
      ..color = Colors.black
          .withOpacity(0.6) // Reduced opacity
      ..strokeWidth =
          4.0 // Reduced from 6.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.outer,
        2.0,
      ); // Reduced blur

    final redOutlinePaint = Paint()
      ..color = Colors.red
      ..strokeWidth =
          2.0 // Reduced from 3.0
      ..style = PaintingStyle.stroke;

    final faceContour = face.contours[FaceContourType.face];
    if (faceContour != null) {
      final path = Path();
      final points = faceContour.points;
      if (points.isNotEmpty) {
        final firstPoint = _translator.translatePoint(
          points.first.x.toDouble(),
          points.first.y.toDouble(),
          size,
        );
        path.moveTo(firstPoint.dx, firstPoint.dy);

        for (int i = 1; i < points.length; i++) {
          final point = _translator.translatePoint(
            points[i].x.toDouble(),
            points[i].y.toDouble(),
            size,
          );
          path.lineTo(point.dx, point.dy);
        }
        path.close();
        canvas.drawPath(path, darkOutlinePaint);
        canvas.drawPath(path, redOutlinePaint);
      }
    }
  }

  void _drawMenacingMouth(Canvas canvas, Face face, Size size) {
    final bottomLip = face.contours[FaceContourType.lowerLipBottom];
    final upperLip = face.contours[FaceContourType.upperLipTop];

    final mouthPaint = Paint()
      ..color = Colors.black
      ..strokeWidth =
          3.0 // Reduced from 4.0
      ..style = PaintingStyle.stroke;

    final mouthGlowPaint = Paint()
      ..color = Colors.red
          .withOpacity(0.5) // Reduced opacity
      ..strokeWidth =
          4.0 // Reduced from 6.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.outer,
        2.0,
      ); // Reduced blur

    if (bottomLip != null && upperLip != null) {
      final path = Path();
      final upperPoints = upperLip.points;
      if (upperPoints.isNotEmpty) {
        final firstPoint = _translator.translatePoint(
          upperPoints.first.x.toDouble(),
          upperPoints.first.y.toDouble(),
          size,
        );
        path.moveTo(firstPoint.dx, firstPoint.dy);

        for (int i = 1; i < upperPoints.length; i++) {
          final point = _translator.translatePoint(
            upperPoints[i].x.toDouble(),
            upperPoints[i].y.toDouble(),
            size,
          );
          path.lineTo(point.dx, point.dy);
        }
      }

      canvas.drawPath(path, mouthGlowPaint);
      canvas.drawPath(path, mouthPaint);
    }
  }

  void _drawVillainMark(Canvas canvas, Face face, Size size) {
    final rect = _translator.translateRect(face.boundingBox, size);
    final scarPaint = Paint()
      ..color = Colors.red
          .withOpacity(0.7) // Reduced opacity
      ..strokeWidth =
          2.5 // Reduced from 3.0
      ..style = PaintingStyle.stroke;

    final scarGlowPaint = Paint()
      ..color = Colors.red
          .withOpacity(0.3) // Reduced opacity
      ..strokeWidth =
          5.0 // Reduced from 8.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.outer,
        3.0,
      ); // Reduced blur

    final scarStart = Offset(
      rect.left + rect.width * 0.2,
      rect.top + rect.height * 0.3,
    );
    final scarEnd = Offset(
      rect.right - rect.width * 0.1,
      rect.bottom - rect.height * 0.2,
    );

    canvas.drawLine(scarStart, scarEnd, scarGlowPaint);
    canvas.drawLine(scarStart, scarEnd, scarPaint);
  }

  void _drawMuscularConnections(
    Canvas canvas,
    Pose pose,
    Size size,
    Paint shadowPaint,
    Paint glowPaint,
    Paint corePaint,
    Paint innerPaint,
  ) {
    final connections = PoseConnections.getMuscularConnections();

    for (final connection in connections) {
      final startLandmark = pose.landmarks[connection[0]];
      final endLandmark = pose.landmarks[connection[1]];

      if (startLandmark != null && endLandmark != null) {
        final start = _translator.translatePoint(
          startLandmark.x,
          startLandmark.y,
          size,
        );
        final end = _translator.translatePoint(
          endLandmark.x,
          endLandmark.y,
          size,
        );

        // Draw muscular effect with multiple layers
        canvas.drawLine(start, end, shadowPaint);
        canvas.drawLine(start, end, glowPaint);
        canvas.drawLine(start, end, corePaint);
        canvas.drawLine(start, end, innerPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant PoseAndFacePainter oldDelegate) {
    // Optimized shouldRepaint to reduce unnecessary redraws
    return poses != oldDelegate.poses ||
        faces != oldDelegate.faces ||
        previewSize != oldDelegate.previewSize ||
        isFrontCamera != oldDelegate.isFrontCamera;
  }
}
