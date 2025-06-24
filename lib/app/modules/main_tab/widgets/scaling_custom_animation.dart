
import 'package:flutter/material.dart';

class ScalingCustomAnimation extends FloatingActionButtonAnimator{
  late double _x;
  late double _y;
  @override
  Offset getOffset({required Offset begin, required Offset end, required double progress}) {
    _x = begin.dx +(end.dx - begin.dx)*progress ;
    _y = begin.dy +(end.dy - begin.dy)*progress;
    return Offset(_x,_y);
  }

  @override
  Animation<double> getRotationAnimation({required Animation<double> parent}) {
    // return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
    /// 旋转动画 180度
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }

  @override
  Animation<double> getScaleAnimation({required Animation<double> parent}) {
    return Tween<double>(begin: 1.0, end: 1.0).animate(parent);
  }
}