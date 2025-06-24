import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_refresh/easy_refresh.dart';

class EasyRefresherHeader extends Header {
  final bool showNoDataWidget;

  EasyRefresherHeader({this.showNoDataWidget = true})
      : super(
          triggerOffset: 50.w,
          clamping: true,
          position: IndicatorPosition.locator,
          safeArea: true,
        );

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return _EasyRefresherHeaderContent(
      state: state,
    );
  }
}

class _EasyRefresherHeaderContent extends StatefulWidget {
  final IndicatorState state;

  const _EasyRefresherHeaderContent({Key? key, required this.state})
      : super(key: key);

  @override
  State<_EasyRefresherHeaderContent> createState() =>
      _EasyRefresherHeaderContentState();
}

class _EasyRefresherHeaderContentState
    extends State<_EasyRefresherHeaderContent> with TickerProviderStateMixin {
  late final AnimationController _controller;

  IndicatorState get state => widget.state;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..addListener(() {
        if (_controller.isCompleted) {
          _controller.reverse();
        }
      });
  }

  @override
  void didUpdateWidget(covariant _EasyRefresherHeaderContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (state.mode == IndicatorMode.ready) {
      _controller.forward();
    } else if (state.mode == IndicatorMode.drag ||
        state.mode == IndicatorMode.armed) {
      _controller.reset();
    } else if (state.mode == IndicatorMode.done ||
        state.mode == IndicatorMode.inactive) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double offset = state.offset;
    print(offset);
    if (state.mode == IndicatorMode.inactive) {
      return const SizedBox();
    }

    return Container(
      height: offset,
      alignment: Alignment.bottomCenter,
      child: Lottie.asset(
        'assets/json/refresh.json',
        width: 20.w,
        height: 20.w,
        controller: _controller,
        repeat: true,
      ),
    );
  }
}
