import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/controllers/follow_orders_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_search_textField.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

followOrdersNav({bool enabled = false, TextEditingController? controller, Function(String)? onSubmitted}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(44),
      child: AppBar(
        backgroundColor: AppColor.colorWhite,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            if (enabled) {
              Get.toNamed(Routes.SEARCH_INDEX, arguments: {'currentIndex': 4});
            }
          },
          child: Container(
              height: 30.w,
              margin: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: AppColor.colorBackgroundInput,
                borderRadius: BorderRadius.circular(50),
              ),
              child: SearchTextField(
                height: 30,
                enabled: false,
                haveTopPadding: false,
                hintText: LocaleKeys.follow23.tr,
              )),
        ),
        titleSpacing: 0,
      ));
}

class FollowOrdersCustomerTop extends StatelessWidget {
  const FollowOrdersCustomerTop({
    super.key,
    required this.controller,
  });
  final FollowOrdersController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        controller.model.showAnswerView
            ? Obx(() => controller.model.isSetDone.value
                ? controller.model.showTip.value
                    ? InkWell(
                        onTap: () {
                          Get.toNamed(Routes.FOLLOW_QUESTIONNAIRE_RESULT,
                              arguments: {'model': controller.model.queryModel}); //跳转到结果页
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
                          color: const Color(0x192EBD87),
                          child: Row(
                            children: [
                              MyImage(
                                'flow/follow_answer_done'.svgAssets(),
                                width: 20.w,
                                height: 20.w,
                              ),
                              Expanded(
                                  child: Text(LocaleKeys.follow438.tr, style: AppTextStyle.f_12_500.upColor)
                                      .paddingSymmetric(horizontal: 8.w)),
                              InkWell(
                                onTap: () {
                                  controller.model.showTip.value = false;
                                },
                                child: MyImage(
                                  'flow/follow_answer_close'.svgAssets(),
                                  width: 16.w,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : const SizedBox()
                : InkWell(
                    onTap: () {
                      Get.toNamed(Routes.FOLLOW_QUESTIONNAIRE);
                      //END
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
                      color: const Color(0x19FFD428),
                      child: Row(
                        children: [
                          MyImage(
                            'flow/follow_top_answer'.svgAssets(),
                            width: 20.w,
                            height: 20.w,
                          ),
                          Expanded(
                              child: Text(LocaleKeys.follow437.tr,
                                      style: AppTextStyle.f_12_500.copyWith(color: const Color(0xFF734D03)))
                                  .paddingSymmetric(horizontal: 8.w)),
                          MyImage('home/right_small'.pngAssets(), color: const Color(0XFF734D03), width: 16.w, height: 16.w),
                        ],
                      ),
                    ),
                  ))
            : const SizedBox(),
        FollowOrderNavTabbar(
            dataArray: controller.model.mainTabs.map((e) => e.value).toList(), controller: controller.model.mainTabController),
      ],
    );
  }
}

class FollowOrderNavTabbar extends StatelessWidget {
  const FollowOrderNavTabbar({super.key, required this.dataArray, required this.controller});
  final List<String> dataArray;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
      ),
      height: 38.w,
      width: double.infinity,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.colorABABAB,
        labelColor: AppColor.color111111,
        labelStyle: AppTextStyle.f_14_500,
        unselectedLabelStyle: AppTextStyle.f_14_500,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColor.colorBlack, width: 2.h),
        ),
        labelPadding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
        tabs: dataArray
            .map((f) => Tab(
                  child: Align(alignment: Alignment.center, child: Text(f)),
                ))
            .toList(),
      ),
    );
  }
}
