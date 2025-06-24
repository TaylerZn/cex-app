import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';

class CircleProgressChart extends StatelessWidget {
  const CircleProgressChart(
      {super.key,
      required this.progressColor,
      required this.backgroundColor,
      required this.percent,
      required this.size,
      this.textStyle,
      required this.strokeWidth});

  final Color progressColor;
  final Color backgroundColor;
  final double percent;
  final double size;
  final double strokeWidth;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CircleProgressPainter(
          progressColor,
          backgroundColor,
          percent,
          textStyle,
          strokeWidth,
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  _CircleProgressPainter(
    this.progressColor,
    this.backgroundColor,
    this.percent,
    this.textStyle,
    this.strokeWidth,
  );

  final Color progressColor;
  final Color backgroundColor;
  final double percent;
  final double strokeWidth;
  final TextStyle? textStyle;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -pi / 2,
      2 * pi * percent,
      false,
      progressPaint,
    );

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '${(percent * 100).toInt()}%',
        style: textStyle ?? AppTextStyle.f_9_600.copyWith(color: progressColor),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2,
          (size.height - textPainter.height) / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
