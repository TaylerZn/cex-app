import 'package:flutter/material.dart';

///类似于Android中的PopupWindow
class PopupWindow extends StatefulWidget {
  static void showPopWindow({
    required BuildContext context,
    required Widget popWidget,
    required GlobalKey popKey,
  }) {
    Navigator.push(
      context,
      PopRoute(
        child: PopupWindow(
          popKey,
          popWidget,
        ),
      ),
    );
  }

  final GlobalKey popKey;
  final Widget popWidget; //自定义widget

  PopupWindow(this.popKey, this.popWidget, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopupWindowState();
  }
}

class _PopupWindowState extends State<PopupWindow> {
  late GlobalKey buttonKey;
  double top = -100;
  double height = 0;

  @override
  void initState() {
    super.initState();
    buttonKey = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox =
          widget.popKey.currentContext?.findRenderObject() as RenderBox;
      Offset localToGlobal =
          renderBox.localToGlobal(Offset.zero); //targetWidget的坐标位置
      Size size = renderBox.size; //targetWidget的size

      RenderBox buttonBox =
          buttonKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        height = buttonBox.size.height;
        top = localToGlobal.dy + size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            Positioned(
              left: 0,
              top: top,
              child: Stack(
                children: [
                  if(top >= 0) Container(
                    height: MediaQuery.of(context).size.height - top,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  AnimatedContainer(
                    height: height,
                    duration: const Duration(milliseconds: 200),
                    child: SingleChildScrollView(
                      child: _buildCustomWidget(widget.popWidget),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildCustomWidget(Widget child) => Container(
        key: buttonKey,
        child: child,
      );
}

class PopRoute extends PopupRoute {
  final Duration _duration = const Duration(milliseconds: 200);
  final Widget child;

  PopRoute({required this.child});

  @override
  Color get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => '';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
