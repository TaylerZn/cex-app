import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/utilities/ontap_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class MyDottedLine extends StatelessWidget {
  final double lineHeight;
  final double lineWidthRatio;
  final double dashWidth;
  final double dashSpace;
  final Color colorLineColor;
  final GestureTapCallback? onTap;
  final bool isCenter;
  final double textPaddingBottom;

  const MyDottedLine(
      {Key? key,
      this.lineHeight = 1,
      this.lineWidthRatio = 1.0,
      this.dashWidth = 2,
      this.dashSpace = 2,
      this.colorLineColor = AppColor.color999999,
      this.onTap,
      this.isCenter = true,
      this.textPaddingBottom = 3.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lineWidth = lineWidthRatio;
    final totalHeight = 10.0;
    return CustomPaint(
      painter: DottedLinePainter(
        width: lineWidth,
        height: lineHeight,
        startY: 0, //fontSize + textPaddingBottom, // 下划线的起始 Y 位置
        color: colorLineColor,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
      child: Container(
        height: totalHeight,
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final double width;
  final double height;
  final double startY;
  final Color color;
  final double dashWidth;
  final double dashSpace;

  DottedLinePainter({
    required this.width,
    required this.height,
    required this.startY,
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = height; // 使用 lineHeight 作为画笔宽度

    double startX = (size.width - width) / 2;
    double currentX = startX;
    while (currentX < startX + width) {
      canvas.drawLine(
        Offset(currentX, startY + height / 2), // 考虑到线宽
        Offset(currentX + dashWidth, startY + height / 2),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
