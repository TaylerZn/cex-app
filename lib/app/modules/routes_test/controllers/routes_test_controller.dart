import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/assets/assets_overview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RoutesTestController extends GetxController {
  AssetsOverView? assetsData;

  @override
  void onInit() {
    String? parametersData = Get.parameters['data'];
    // 将字符串转换为Map<String, dynamic>
    Map<String, dynamic> dataMap = jsonDecode(parametersData ?? '{}');
    assetsData = AssetsOverView.fromJson(dataMap);
    // if (parametersData != null) {
    //   Map<String, dynamic> dataMap = jsonDecode(parametersData);
    //   assetsData = AssetsOverView.fromJson(dataMap);
    // }

    // AssetsOverView.fromJson(a)
    print(assetsData);
    super.onInit();
  }
}
