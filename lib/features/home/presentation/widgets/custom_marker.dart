import 'package:flutter/material.dart';

class CustomMarker extends CustomPainter {
  final Color color;
  CustomMarker({this.color = const Color(0xff952CC9)});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.2400000;
    paint0Stroke.color = Colors.white.withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.4969640, size.height * 0.4969640),
        size.width * 0.3769656, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color.withOpacity(1.0);
    canvas.drawCircle(Offset(size.width * 0.4969640, size.height * 0.4969640),
        size.width * 0.3769656, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
