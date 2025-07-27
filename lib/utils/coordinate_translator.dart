import 'dart:ui';

class CoordinateTranslator {
  final Size previewSize;
  final bool isFrontCamera;

  CoordinateTranslator(this.previewSize, this.isFrontCamera);

  Offset translatePoint(double x, double y, Size size) {
    // Translate coordinates from camera space to screen space
    final double scaleX = size.width / previewSize.height;
    final double scaleY = size.height / previewSize.width;

    return Offset(
      isFrontCamera
          ? size.width - (x * scaleX)
          : x * scaleX, // Flip horizontally for front camera
      y * scaleY,
    );
  }

  Rect translateRect(Rect rect, Size size) {
    final double scaleX = size.width / previewSize.height;
    final double scaleY = size.height / previewSize.width;

    if (isFrontCamera) {
      return Rect.fromLTRB(
        size.width - (rect.right * scaleX),
        rect.top * scaleY,
        size.width - (rect.left * scaleX),
        rect.bottom * scaleY,
      );
    } else {
      return Rect.fromLTRB(
        rect.left * scaleX,
        rect.top * scaleY,
        rect.right * scaleX,
        rect.bottom * scaleY,
      );
    }
  }
}
