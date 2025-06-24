import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/utilities/ontap_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class MyDottedText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final double lineHeight;
  final double lineWidthRatio;
  final double dashWidth;
  final double dashSpace;
  final Color colorLineColor;
  final GestureTapCallback? onTap;
  final bool isCenter;
  final double textPaddingBottom;

  const MyDottedText(this.data,
      {Key? key,
      this.style,
      this.lineHeight = 0.5,
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
    final TextStyle effectiveStyle =
        style ?? DefaultTextStyle.of(context).style;
    final fontSize = effectiveStyle.fontSize ?? 14.0;

    final textPainter = TextPainter(
      text: TextSpan(text: data, style: effectiveStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    final textWidth = textPainter.width;

    final lineWidth = textWidth * lineWidthRatio;
    final totalHeight =
        fontSize + textPaddingBottom + lineHeight; // 文字高度 + 间距 + 下划线高度

    return InkWell(
        onTap: throttle(() async {
          if (onTap != null) {
            onTap!();
          }
        }),
        child: CustomPaint(
          painter: DottedLinePainter(
            width: lineWidth,
            height: lineHeight,
            startY: fontSize + textPaddingBottom, // 下划线的起始 Y 位置
            color: colorLineColor,
            dashWidth: dashWidth,
            dashSpace: dashSpace,
          ),
          child: Container(
              height: totalHeight,
              child: isCenter
                  ? Center(
                      child: Text(
                        data,
                        style: effectiveStyle,
                      ),
                    )
                  : Text(
                      data,
                      style: effectiveStyle,
                    )),
        ));
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
