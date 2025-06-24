
import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension FocusNodeExtension on FocusNode {
  focus() {
    if(Get.context == null) return;
    FocusScope.of(Get.context!).requestFocus(this);
  }
}