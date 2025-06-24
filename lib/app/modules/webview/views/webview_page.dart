import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/webview/controllers/webview_controller.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends GetView<WebPageController> {
  const WebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const MyPageBackWidget(),
          title: Obx(() => Text(
                controller.barTitle.value,
                style: TextStyle(fontSize: 16.w),
              )),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            _progressBar(context),
            WebViewWidget(controller: controller.controller),
          ],
        ));
  }

  Widget _progressBar(context) {
    return Obx(() => controller.isLoading.value
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/json/loading.json',
                    repeat: true,
                    width: 60.w,
                  ),
                  Visibility(
                      visible: controller.progress.value != 0 &&
                          controller.progress.value != 100,
                      child: Text(
                        '${controller.progress.value}%',
                        style: AppTextStyle.f_14_500,
                      ))
                ]))
        : const SizedBox());
  }
}
