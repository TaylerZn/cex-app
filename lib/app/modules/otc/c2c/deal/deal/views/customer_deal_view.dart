import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal/widgets/customer_deal_top.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../controllers/customer_deal_controller.dart';

class CustomerDealView extends GetView<CustomerDealController> {
  const CustomerDealView({super.key});

  @override
  Widget build(BuildContext context) {
    return MySystemStateBar(
      child: GetBuilder(
          init: controller,
          builder: (c) {
            return VisibilityDetector(
              key: const Key('CustomerDealView'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction == 1) {
                  controller.getAdertData();
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: const MyPageBackWidget(),
                  title: Text(controller.title),
                  centerTitle: true,
                ),
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    CustomerDealTopView(controller: controller),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: getButton(context, controller))
                  ],
                ),
                // bottomNavigationBar: getButton(context, controller)
              ),
            );
          }),
    );
  }

  Widget getButton(context, CustomerDealController controller) {
    return GestureDetector(
      onTap: () {
        controller.placeAnOrde();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: AppColor.colorWhite,
          border: Border(
            top: BorderSide(width: 1.0, color: AppColor.colorBorderGutter),
          ),
        ),
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        height: 80.h,
        child: Obx(
          () => Container(
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              color: (controller.selectIndex.value > -1 &&
                      controller.showError.value == false &&
                      controller.model.avaiableNum.value.isNotEmpty)
                  ? AppColor.color111111
                  : AppColor.colorEEEEEE,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            height: 48.h,
            child: Text(
                '${controller.isBuy ? LocaleKeys.c2c191.tr : LocaleKeys.c2c192.tr}  USDT',
                style: AppTextStyle.f_16_600.colorWhite),
          ),
        ),
      ),
    );
  }
}
