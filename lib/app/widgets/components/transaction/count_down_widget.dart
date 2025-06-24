import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget(
      {super.key, required this.endTime, required this.stopCallback});

  final int endTime;
  final VoidCallback stopCallback;

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  /// 倒计时
  late StreamController<int> _secondsStreamController;
  late Stream<int> _secondsStream;
  Timer? _timer;
  bool _isTimerRunning = true;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _seconds = widget.endTime ~/ 1000;
    _secondsStreamController = StreamController<int>.broadcast();
    _secondsStream = _secondsStreamController.stream;
    _startTimer();
  }

  _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isTimerRunning) {
        _seconds--;
        if (_seconds <= 0) {
          widget.stopCallback();
          _stopTimer();
        }
        _secondsStreamController.add(_seconds);
      } else {
        _timer?.cancel();
      }
    });
  }

  _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _isTimerRunning = false;
  }

  @override
  void dispose() {
    _stopTimer();
    _secondsStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _secondsStream,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.data == 0) {
          return Text(
            '00:00:00',
            style: AppTextStyle.f_11_400.copyWith(
              color: AppColor.color666666,
            ),
          );
        }
        // 描述格式化
        String format = '';
        // 时分秒
        int hour = snapshot.data! ~/ 3600;
        int minutes = (snapshot.data! % 3600) ~/ 60;
        int seconds = snapshot.data! % 60;
        format =
            '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        return Text(
          format,
          style: AppTextStyle.f_11_400.copyWith(
            color: AppColor.color666666,
          ),
        );
      },
    );
  }
}
