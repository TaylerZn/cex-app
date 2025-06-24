import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/model/follow_manage_list.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_stack.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/widgets/follow_taker_bar.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/my_shield_enum.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/widget/my_take_manage.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../controllers/my_take_shield_controller.dart';

class MyTakeShieldView extends GetView<MyTakeShieldController> {
  const MyTakeShieldView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const MyPageBackWidget(),
          title: Text(LocaleKeys.follow224.tr),
          centerTitle: true,
          actions: [
            Obx(() => controller.currentIndex.value == 0
                ? Center(
                    child: GestureDetector(
                      onTap: () {
                        // if (controller.currentIndex == 0) {
                        var model = controller.currentOrder.value;
                        model.isSelected = !model.isSelected;
                        controller.currentOrder.value = FollowMyManageListModel.fromJson(model.toJson());
                        // } else {
                        //   var model = controller.applyOrder.value;
                        //   model.isSelected = !model.isSelected;
                        //   controller.applyOrder.value = FollowkolApplyModel.fromJson(model.toJson());
                        // }
                      },
                      child: Obx(() => Text(
                          (controller.currentOrder.value.isSelected || controller.applyOrder.value.isSelected)
                              ? LocaleKeys.follow237.tr
                              : LocaleKeys.follow13.tr,
                          style: AppTextStyle.f_14_500.color666666)),
                    ),
                  )
                : const SizedBox()),
            IconButton(
              onPressed: () => showBlackActionSheetView(controller.actionDisplayList),
              icon: MyImage(
                'flow/follow_manage_right'.svgAssets(),
                width: 18,
              ),
            )
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(LocaleKeys.follow238.tr, style: AppTextStyle.f_13_500.color333333),
                        Text(LocaleKeys.follow225.tr, style: AppTextStyle.f_13_500.color333333)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(controller.infoModel.totalEarningsStr,
                            style: AppTextStyle.f_18_500.copyWith(color: controller.infoModel.totalEarningsColor)),
                        Text(controller.infoModel.sumShareProfitStr,
                            style: AppTextStyle.f_18_500.copyWith(color: controller.infoModel.sumShareProfitColor))
                      ],
                    ).marginOnly(top: 2.h, bottom: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(LocaleKeys.follow226.tr, style: AppTextStyle.f_12_400.color999999),
                        Text('${controller.infoModel.followAmountStr} USDT', style: AppTextStyle.f_12_400.color333333)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(LocaleKeys.follow227.tr, style: AppTextStyle.f_12_400.color999999),
                        Text(controller.infoModel.currentFollowCountStr, style: AppTextStyle.f_12_400.color333333)
                      ],
                    ).marginOnly(top: 10.h, bottom: 15.h),
                  ],
                ),
              )),
              SliverPinnedHeader(
                child: FollowTakerTabbar(
                  controller: controller.tabController,
                  dataArray: controller.tabs.map((e) => e.value).toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
              controller: controller.tabController,
              children: controller.tabs.map((type) {
                return MyTakeManageList(controller: controller, type: type);
              }).toList()),
        ),
        bottomNavigationBar: Obx(() => (controller.currentOrder.value.isSelected || controller.applyOrder.value.isSelected)
            ? Container(
                height: 80.h,
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                padding: EdgeInsets.only(right: 16.w),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: Color(0xFFF1F1F1),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          if (controller.currentIndex.value == 0) {
                            var model = controller.currentOrder.value;
                            model.isSelectedAll.value = !model.isSelectedAll.value;
                            model.list?.forEach((element) {
                              element.isSelected.value = model.isSelectedAll.value;
                            });
                          } else {
                            var model = controller.applyOrder.value;
                            model.isSelectedAll.value = !model.isSelectedAll.value;
                            model.list?.forEach((element) {
                              element.isSelected.value = model.isSelectedAll.value;
                            });
                          }
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Obx(() => Container(
                              // color: Colors.amber,
                              padding: EdgeInsets.only(left: 16.w, right: 8.w),
                              child: MyImage(
                                'contract/${(controller.currentOrder.value.isSelectedAll.value || controller.applyOrder.value.isSelectedAll.value) ? 'follow_select' : 'market_unSelect'}'
                                    .svgAssets(),
                                width: 20.w,
                              ),
                            ))),
                    Text(LocaleKeys.follow228.tr, style: AppTextStyle.f_14_500.color4D4D4D),
                    const Spacer(),
                    MyButton(
                      height: 48.h,
                      text: LocaleKeys.follow229.tr,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      onTap: () => Get.dialog(
                          transitionDuration: const Duration(milliseconds: 25),
                          MyFollowDialog(
                              textVC: controller.textVC,
                              isManage: true,
                              isSingleManage: false,
                              callback: () => controller.postAllUser())),
                    )
                  ],
                ),
              )
            : const SizedBox()));
  }

  showBlackActionSheetView(List array) {
    showModalBottomSheet(
      context: Get.context!,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
          ),
          padding: EdgeInsets.only(bottom: 24.w + MediaQuery.of(context).padding.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: EdgeInsets.only(top: 16.h, bottom: 24.h),
                  decoration: ShapeDecoration(
                    color: AppColor.color999999,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: array.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.MY_TAKE_BLOCK,
                          arguments: {'type': index == 0 ? MyTakeShieldActionType.prohibit : MyTakeShieldActionType.blacklist});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
                      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 7.h),
                      decoration: ShapeDecoration(
                        color: AppColor.colorF5F5F5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Row(
                        children: [
                          MyImage(
                            'flow/${index == 0 ? 'follow_prohibit' : 'follow_blacklist'}'.svgAssets(),
                            width: 18.w,
                          ),
                          SizedBox(width: 4.w),
                          Text(array[index], style: AppTextStyle.f_16_500.color111111),
                          const Spacer(),
                          MyImage(
                            'default/go'.svgAssets(),
                            width: 14.w,
                            color: AppColor.color4D4D4D,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
    // MediaQuery.of(context).padding.bottom
  }
}
