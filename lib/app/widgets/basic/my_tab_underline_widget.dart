import 'package:flutter/material.dart';

class MyUnderlineTabIndicator extends Decoration {
  /// Create an underline style selected tab indicator.
  const MyUnderlineTabIndicator({
    this.borderRadius,
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
    this.lineWidth,
  });

  /// The radius of the indicator's corners.
  ///
  /// If this value is non-null, rounded rectangular tab indicator is
  /// drawn, otherwise rectangular tab indictor is drawn.
  final BorderRadius? borderRadius;

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the tab
  /// indicator's bounds in terms of its (centered) tab widget with
  /// [TabBarIndicatorSize.label], or the entire tab with
  /// [TabBarIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  final double? lineWidth;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(this, borderRadius, onChanged);
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    if (lineWidth != null) {
      final Rect indicator = insets.resolve(textDirection).deflateRect(rect);

      //希望的宽度
      double wantWidth = lineWidth!;
      //取中间坐标
      double cw = (indicator.left + indicator.right) / 2;
      return Rect.fromLTWH(cw - wantWidth / 2,
          indicator.bottom - borderSide.width, wantWidth, borderSide.width);
    } else {
      final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
      return Rect.fromLTWH(
        indicator.left,
        indicator.bottom - borderSide.width,
        indicator.width,
        borderSide.width,
      );
    }
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    if (borderRadius != null) {
      return Path()
        ..addRRect(
            borderRadius!.toRRect(_indicatorRectFor(rect, textDirection)));
    }
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}
// class MyUnderlineTabIndicator extends Decoration {
//   const MyUnderlineTabIndicator({
//     this.borderSide = const BorderSide(width: 2.0, color: Color(0xff111111)),
//     this.insets = EdgeInsets.zero,
//     this.lineWidth = 10,
//   });

//   /// The color and weight of the horizontal line drawn below the selected tab.
//   final BorderSide borderSide;

//   /// Locates the selected tab's underline relative to the tab's boundary.
//   ///
//   /// The [TabBar.indicatorSize] property can be used to define the tab
//   /// indicator's bounds in terms of its (centered) tab widget with
//   /// [TabBarIndicatorSize.label], or the entire tab with
//   /// [TabBarIndicatorSize.tab].
//   final EdgeInsetsGeometry insets;

//   final double lineWidth;

//   @override
//   Decoration? lerpFrom(Decoration? a, double t) {
//     if (a is MyUnderlineTabIndicator) {
//       return MyUnderlineTabIndicator(
//         borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
//         insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
//       );
//     }
//     return super.lerpFrom(a, t);
//   }

//   @override
//   Decoration? lerpTo(Decoration? b, double t) {
//     if (b is MyUnderlineTabIndicator) {
//       return MyUnderlineTabIndicator(
//         borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
//         insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
//       );
//     }
//     return super.lerpTo(b, t);
//   }

//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
//     return _UnderlinePainter(this, onChanged);
//   }

//   Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
//     final Rect indicator = insets.resolve(textDirection).deflateRect(rect);

//     //希望的宽度
//     double wantWidth = lineWidth;
//     //取中间坐标
//     double cw = (indicator.left + indicator.right) / 2;
//     return Rect.fromLTWH(cw - wantWidth / 2,
//         indicator.bottom - borderSide.width, wantWidth, borderSide.width);
//   }

//   @override
//   Path getClipPath(Rect rect, TextDirection textDirection) {
//     return Path()..addRect(_indicatorRectFor(rect, textDirection));
//   }
// }

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(
    this.decoration,
    this.borderRadius,
    super.onChanged,
  );

  final MyUnderlineTabIndicator decoration;
  final BorderRadius? borderRadius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Paint paint;
    if (borderRadius != null) {
      paint = Paint()..color = decoration.borderSide.color;
      final Rect indicator = decoration._indicatorRectFor(rect, textDirection);
      final RRect rrect = RRect.fromRectAndCorners(
        indicator,
        topLeft: borderRadius!.topLeft,
        topRight: borderRadius!.topRight,
        bottomRight: borderRadius!.bottomRight,
        bottomLeft: borderRadius!.bottomLeft,
      );
      canvas.drawRRect(rrect, paint);
    } else {
      paint = decoration.borderSide.toPaint()..strokeCap = StrokeCap.square;
      final Rect indicator = decoration
          ._indicatorRectFor(rect, textDirection)
          .deflate(decoration.borderSide.width / 2.0);
      canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
    }
  }
}



// class MyCustomIndicator extends Decoration {
//   final double indWidth;
//   final double indHeight;
//   final double radius;
//   final Color color;

//   const MyCustomIndicator(
//       {this.indWidth = 10,
//       this.indHeight = 2,
//       this.radius = 0,
//       this.color = AppColor.mainColor});

//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
//     return _CustomBoxPainter(
//         this, onChanged, indWidth, indHeight, radius, color);
//   }
// }

// class _CustomBoxPainter extends BoxPainter {
//   final MyCustomIndicator decoration;
//   final double indWidth;
//   final double indHeight;
//   final double radius;
//   final Color color;

//   _CustomBoxPainter(this.decoration, VoidCallback? onChanged, this.indWidth,
//       this.indHeight, this.radius, this.color)
//       : super(onChanged);

//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
//     final size = configuration.size!;
//     final newOffset = Offset(
//         offset.dx + (size.width - indWidth) / 2, size.height - indHeight);
//     final Rect rect = newOffset & Size(indWidth, indHeight);
//     final Paint paint = Paint();
//     paint.color = color;
//     paint.style = PaintingStyle.fill;
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(rect, Radius.circular(radius)), // 圆角半径
//       paint,
//     );
//   }
// }
