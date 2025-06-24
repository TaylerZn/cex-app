import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_stack.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_parting/controllers/my_take_parting_controller.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:sliver_tools/sliver_tools.dart';

//

class MyPartTop extends StatelessWidget {
  const MyPartTop({
    super.key,
    required this.controller,
  });
  final MyTakePartingController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.only(left: 16.w, right: 0, top: 20.w, bottom: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${LocaleKeys.follow214.tr}(USDT)', style: AppTextStyle.f_14_600.color111111),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.w),
                    child: Text(controller.infoModel.sumShareProfitStr, style: AppTextStyle.f_28_600.color111111),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.w),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 110.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${LocaleKeys.follow215.tr}(USDT)', style: AppTextStyle.f_11_400.color999999)
                                  .marginOnly(bottom: 2.h),
                              Text(controller.infoModel.latestShareProfitStr, style: AppTextStyle.f_14_500.color4D4D4D),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.follow184.tr, style: AppTextStyle.f_11_400.color999999).marginOnly(bottom: 2.h),
                            Obx(() => Text('${controller.rateStr.value}%', style: AppTextStyle.f_14_500.color4D4D4D))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MyImage('assets/images/contract/my_commission_top_right.png', width: 77.w, height: 90.w)
                  .paddingOnly(bottom: 20.w),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MyButton(
                    text: LocaleKeys.follow216.tr,
                    color: Colors.white,
                    textStyle: AppTextStyle.f_15_600,
                    backgroundColor: Colors.black,
                    height: 40.h,
                    onTap: () => Get.dialog(
                        transitionDuration: const Duration(milliseconds: 25),
                        MyFollowDialog(
                          textVC: controller.textVC,
                          btnEnabled: controller.rateStrEnabled,
                          callback: controller.editCommission,
                        ))),
              ),
              SizedBox(width: 10.w),
              Expanded(
                  child: MyButton.borderWhiteBg(
                      text: LocaleKeys.follow498.tr,
                      textStyle: AppTextStyle.f_15_600,
                      height: 40.h,
                      onTap: () => Get.dialog(
                          transitionDuration: const Duration(milliseconds: 25),
                          MyFollowDialog(
                            textVC: controller.textVC2,
                            title: LocaleKeys.follow499.tr,
                            des: LocaleKeys.follow500.tr,
                            des2: LocaleKeys.follow501.tr,
                            linkdes: LocaleKeys.follow502.tr,
                            btnEnabled: controller.rateStr2Enabled,
                            linkdesCallback: () {
                              Get.toNamed(Routes.WEBVIEW, arguments: {'url': LinksGetx.to.proxyRules});
                            },
                            callback: controller.editAgentCommission,
                          ))).paddingOnly(right: 16.w)),
            ],
          )
        ],
      ),
    ));
  }
}

class MyTakeTabbar extends StatelessWidget {
  const MyTakeTabbar({super.key, required this.dataArray, required this.controller});
  final List<String> dataArray;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
        ),
      ),
      height: 40.h,
      width: double.infinity,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.color999999,
        labelColor: AppColor.color111111,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColor.colorBlack,
            width: 2.h,
          ),
          insets: EdgeInsets.only(left: 14.w, right: 14.w, top: 0, bottom: 0),
        ),
        labelPadding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
        tabs: dataArray
            .map((f) => Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(f),
                  ),
                ))
            .toList(),
      ),
    ));
  }
}
