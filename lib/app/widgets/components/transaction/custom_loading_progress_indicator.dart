import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class CustomLoadingProgressIndicator extends StatelessWidget {
  const CustomLoadingProgressIndicator({super.key,  this.width,  this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/json/refresh.json',
        width: width ?? 24.w,
        height: height ?? 24.w,
        repeat: true,
      ),
    );
  }
}
