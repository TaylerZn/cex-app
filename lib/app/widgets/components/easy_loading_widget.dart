import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

/// This example show how to play the Lottie animation in various way:
/// - Start and stop the animation on event callback
/// - Play the animation forward and backward
/// - Loop between two specific frames

/// This works by creating an AnimationController instance and passing it
/// to the Lottie widget.
/// The AnimationController class has a rich API to run the animation in various ways.

class EasyLoadingWidget extends StatefulWidget {
  @override
  State<EasyLoadingWidget> createState() => _EasyLoadingWidgetState();
}

class _EasyLoadingWidgetState extends State<EasyLoadingWidget>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 54.w,
        height: 54.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/json/loading.json',
              repeat: true,
              width: 34.w,
              height: 26.w,
            )
          ],
        ));
  }
}
