import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeUtil {
  static void init() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );
  }
}
