import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class AppUtil {
  static void nextTick(VoidCallback callback) {
    Future.delayed(const Duration(), () {
      callback();
    });
  }

  static void hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
