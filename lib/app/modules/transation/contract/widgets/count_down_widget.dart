import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget(
      {super.key, required this.nextCapitalTime, required this.onCountDownEnd});

  final int nextCapitalTime;
  final VoidCallback onCountDownEnd;

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  Timer? _timer;
  late ValueNotifier<String> _countdownNotifier;
  int _nextCapitalTime = 0;

  @override
  void initState() {
    super.initState();
    _nextCapitalTime = widget.nextCapitalTime;
    _countdownNotifier = ValueNotifier<String>('00:00:00');
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _countdownNotifier.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _nextCapitalTime -= 1000;
      if (_nextCapitalTime <= 0) {
        _timer?.cancel();
        widget.onCountDownEnd();
        return;
      }
      int hour = _nextCapitalTime ~/ 3600000;
      int minute = (_nextCapitalTime - hour * 3600000) ~/ 60000;
      int second = (_nextCapitalTime - hour * 3600000 - minute * 60000) ~/ 1000;

      /// 格式化为 00:00:00
      _countdownNotifier.value =
          '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _countdownNotifier,
      builder: (context, value, _) {
        return Text(
          value,
          style: AppTextStyle.f_11_500.color333333,
        );
      },
    );
  }
}
