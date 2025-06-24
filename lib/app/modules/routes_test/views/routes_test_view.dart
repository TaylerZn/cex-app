import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/routes_test/controllers/routes_test_controller.dart';
import 'package:nt_app_flutter/app/modules/webview/controllers/webview_controller.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class RoutesTestView extends GetView<RoutesTestController> {
  const RoutesTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const MyPageBackWidget(),
          title: const Text('路由测试'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Text('路由Data=${Get.parameters['data'] ?? '暂无数据'}')
                .marginOnly(bottom: 50.h),
            Text('路由Model-balance=${controller.assetsData?.balance ?? '0'}')
          ],
        ));
  }
}
