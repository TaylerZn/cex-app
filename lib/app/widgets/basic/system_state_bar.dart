import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum SystemColor { white, black }

//设置顶部颜色与点击收回键盘
class MySystemStateBar extends StatelessWidget {
  final SystemColor color;
  final Widget child;
  const MySystemStateBar(
      {super.key, this.color = SystemColor.black, required this.child});

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle theme;
    if (color == SystemColor.black) {
      theme = SystemUiOverlayStyle.dark;
    } else {
      theme = SystemUiOverlayStyle.light;
    }

    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: theme,
        child: Material(
            color: Colors.transparent,
            child: child,),
      ),
    );
  }
}
