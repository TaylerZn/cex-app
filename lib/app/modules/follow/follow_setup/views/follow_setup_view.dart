import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/widgets/follow_setup_list.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/widgets/follow_setup_sheet.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/follow_setup_controller.dart';

//
class FollowSetupView extends GetView<FollowSetupController> {
  const FollowSetupView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return MySystemStateBar(
      color: SystemColor.black,
      child: PopScope(
        canPop: controller.isGuide == false,
        child: Scaffold(
            backgroundColor: AppColor.colorWhite,
            appBar: AppBar(
              leading: const MyPageBackWidget(),
              title: Text(controller.isSmart ? '' : LocaleKeys.follow63.tr),
              centerTitle: true,
              actions: [
                controller.isEdit
                    ? Obx(() => GestureDetector(
                          onTap: () {
                            if (controller.cancelDetail.value.name != null) {
                              showCancelFollowSureView(
                                  callback: () => controller.cancelFollow(),
                                  cacelModel: controller.cancelDetail.value,
                                  trader: controller.trader);
                            }
                          },
                          child: Center(
                              child: Text(LocaleKeys.follow64.tr,
                                      style: AppTextStyle.f_14_500.copyWith(
                                          color: controller.cancelDetail.value.name == null
                                              ? AppColor.color999999
                                              : AppColor.color666666))
                                  .paddingOnly(right: 16.w)),
                        ))
                    : const SizedBox()
              ],
            ),
            body: GetBuilder(
                init: controller,
                builder: (c) {
                  return FollowSetupListView(
                    controller: controller,
                  );
                }),
            bottomNavigationBar: controller.isSmart
                ? FollowSetuPBottomBtn(
                    isChecked: controller.isChecked,
                    callback: () {
                      if (controller.verifyData(isSmart: true)) {
                        showFollowSureView(
                            callback: controller.postSmartData,
                            model: controller.followInfo,
                            trader: controller.trader,
                            isSmart: true);
                      }
                    })
                : FollowSetuPBottomBtn(
                    isChecked: controller.isChecked,
                    callback: () {
                      if (controller.verifyData()) {
                        showFollowSureView(
                            callback: controller.postData, model: controller.followInfo, trader: controller.trader);
                      }
                    },
                  )),
      ),
    );
  }
}
