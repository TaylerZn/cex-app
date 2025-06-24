import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/my/weal_index/controllers/weal_index_controller.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WealIndexView extends GetView<WealIndexController> {
  const WealIndexView({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('WealIndexView'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1) {
          if (controller.canReload) {
            controller.controller.reload();
          }
        }
      },
      child: Scaffold(
          backgroundColor: AppColor.colorBlack,
          appBar: AppBar(
            leading: const MyPageBackWidget(
              backColor: AppColor.colorWhite,
            ),
            title: Text(
              controller.title.tr,
              style: AppTextStyle.f_16_600.colorWhite,
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: AppColor.colorBlack,
          ),
          body: Stack(
            children: [
              navBar(context),
              WebViewWidget(controller: controller.controller),
            ],
          )),
    );
  }

  Widget navBar(context) {
    return Obx(() => controller.isLoading.value
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
              Lottie.asset(
                'assets/json/loading.json',
                repeat: true,
                width: 60.w,
              ),
              Visibility(
                  visible: controller.progress.value != 0 && controller.progress.value != 100,
                  child: Text(
                    '${controller.progress.value}%',
                    style: AppTextStyle.f_14_500,
                  ))
            ]))
        : const SizedBox());
  }
}
