import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';

class CircularChart extends StatelessWidget {
  const CircularChart(
      {super.key, required this.percent, required this.progressColor, required this.backgroundColor, this.width = 40});
  final double percent;
  final Color progressColor;
  final Color backgroundColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width,
      child: CustomPaint(painter: CircularPainter(percent, progressColor, backgroundColor)),
    );
  }
}

class CircularPainter extends CustomPainter {
  final double percent;
  final Color progressColor;
  final Color backgroundColor;

  CircularPainter(this.percent, this.progressColor, this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintBackground = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final Paint paintProgress = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, paintBackground);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * percent,
      false,
      paintProgress,
    );

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '${(percent * 100).toInt()}%',
        style: TextStyle(
          color: AppColor.downColor,
          fontSize: 12.0.sp,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
