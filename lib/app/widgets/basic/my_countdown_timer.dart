import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';

class MyCountdownTimer extends StatefulWidget {
  final int endTime; // 以秒为单位的时间戳
  final VoidCallback? onCountdownComplete; // 倒计时结束时执行的方法
  final TextStyle? textStyle;

  const MyCountdownTimer(
      {super.key,
      required this.endTime,
      this.onCountdownComplete,
      this.textStyle});

  @override
  _MyCountdownTimerState createState() => _MyCountdownTimerState();
}

class _MyCountdownTimerState extends State<MyCountdownTimer> {
  late Timer _timer;
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = Duration(
        seconds:
            widget.endTime - DateTime.now().millisecondsSinceEpoch ~/ 1000);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds <= 0) {
        _timer.cancel();
        if (widget.onCountdownComplete != null) {
          widget.onCountdownComplete!();
        }
      } else {
        setState(() {
          _duration = Duration(seconds: _duration.inSeconds - 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(_duration),
      style: widget.textStyle ?? AppTextStyle.f_12_400.color333333,
    );
  }
}
