import 'package:flutter/material.dart';

class CustomProfilePhotoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);

    path.lineTo(size.width / 2, size.height - 50);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, 0.0);
    path.close();

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = Colors.black.withOpacity(.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(dynamic oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(dynamic oldDelegate) => false;
}
