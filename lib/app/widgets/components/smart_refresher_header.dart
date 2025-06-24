import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SmartRefresherHeader extends StatefulWidget {
  final bool showNoDataWidget;

  const SmartRefresherHeader({Key? key, this.showNoDataWidget = true})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SmartRefresherHeaderState();
  }
}

class SmartRefresherHeaderState extends State<SmartRefresherHeader>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  var isOne = true;
  var marginValue = 1;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..addListener(() {
            if (_controller.isCompleted) {
              _controller.reverse();
            }
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      height: 48.w,
      onModeChange: (RefreshStatus? mode) {
        if (mode == RefreshStatus.refreshing) {
          _controller.reset();
          _controller.forward();
        }
        if (mode == RefreshStatus.completed) {
          // HapticFeedback.vibrate();
        } else {
          _controller.reset();
        }
      },
      builder: (BuildContext context, RefreshStatus? mode) {
        return _buildLoad(mode: mode);
      },
    );
  }

  Widget _buildLoad({RefreshStatus? mode}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Lottie.asset(
            'assets/json/refresh.json',
            width: 20.w,
            height: 20.w,
            controller: (mode == RefreshStatus.refreshing ||
                    mode == RefreshStatus.completed)
                ? null
                : _controller,
            repeat: true,
          ),
        ),
      ],
    );
  }
}
