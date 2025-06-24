import 'package:flutter/material.dart';

class ColorTabIndicator extends Decoration {
  final Color color;
  final double radius;
  final EdgeInsetsGeometry padding;

  const ColorTabIndicator({
    required this.color,
    this.radius = 0.0,
    this.padding = EdgeInsets.zero,
  });

  @override
  _ColorPainter createBoxPainter([VoidCallback? onChanged]) {
    return _ColorPainter(this, onChanged);
  }
}

class _ColorPainter extends BoxPainter {
  final ColorTabIndicator decoration;

  _ColorPainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final Rect paddedRect =
        decoration.padding.resolve(TextDirection.ltr).inflateRect(rect);
    final Paint paint = Paint()..color = decoration.color;
    final RRect rrect =
        RRect.fromRectAndRadius(paddedRect, Radius.circular(decoration.radius));
    canvas.drawRRect(rrect, paint);
  }
}
