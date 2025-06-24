
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Lottie.asset(
        'assets/json/loading.json',
        repeat: true,
        width: 42.w,
        height: 42.w,
      ),
    );
  }
}
