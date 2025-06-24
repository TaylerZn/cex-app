import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyUnderShapeTabIndicator extends Decoration {
  final double radius;
  final Color color;
  final List<BoxShadow>? shadows;

  const MyUnderShapeTabIndicator({this.radius = 24.0, this.color = Colors.white, this.shadows});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomBoxPainter(this, onChanged);
  }
}

class _CustomBoxPainter extends BoxPainter {
  final MyUnderShapeTabIndicator decoration;

  _CustomBoxPainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint()..color = decoration.color;
    // 获取绘制区域
    Rect rect = Rect.fromLTWH(offset.dx, offset.dy, (configuration.size?.width ?? 4.w) - 4.w, configuration.size?.height ?? 0);
    // 左侧圆角矩形
    RRect leftRoundedRect = RRect.fromRectAndRadius(rect, Radius.circular(decoration.radius));
    // 组合形状路径
    Path roundedPath = Path()..addRRect(leftRoundedRect);
    // 绘制
    canvas.drawPath(roundedPath, paint);
    // 如果有阴影定义，绘制阴影
    if (decoration.shadows != null) {
      for (final BoxShadow boxShadow in decoration.shadows!) {
        final Paint shadowPaint = boxShadow.toPaint();
        canvas.drawRect(rect, shadowPaint);
      }
    }
  }
}
