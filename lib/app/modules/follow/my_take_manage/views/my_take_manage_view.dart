import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_shield/model/my_shield_enum.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/my_take_manage_controller.dart';

class MyTakeManageView extends GetView<MyTakeManageController> {
  const MyTakeManageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const MyPageBackWidget(),
          centerTitle: true,
          title: Text(LocaleKeys.follow204.tr),
        ),
        body: GetBuilder(
            init: controller,
            builder: (b) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      // color: Colors.amber,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 14.w),
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.follow205.tr,
                            style: AppTextStyle.f_14_500.color666666,
                          ),
                          const Spacer(),
                          controller.orderShow == null
                              ? Row(
                                  children: [
                                    Container(
                                      width: 4.w,
                                      height: 4.w,
                                      margin: EdgeInsets.only(right: 4.w),
                                      decoration: const ShapeDecoration(
                                        color: Color(0xFFF53F57),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                    Text(
                                      LocaleKeys.follow206.tr,
                                      style: AppTextStyle.f_12_500.color999999,
                                    ),
                                  ],
                                )
                              : Text(
                                  controller.orderShow!,
                                  style: AppTextStyle.f_12_500.color999999,
                                ),
                          SizedBox(width: 4.w),
                          MyImage(
                            'default/go'.svgAssets(),
                            width: 12.w,
                            color: AppColor.color4D4D4D,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      showGrabOrderDisplaySheetView(
                          controller.grabOrderDisplayList,
                          controller.orderShowIndex,
                          0);
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      // color: Colors.amber,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 14.w),
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.follow123.tr,
                            style: AppTextStyle.f_14_500.color666666,
                          ),
                          const Spacer(),
                          controller.orderHistoryShow == null
                              ? Row(
                                  children: [
                                    Container(
                                      width: 4.w,
                                      height: 4.w,
                                      margin: EdgeInsets.only(right: 4.w),
                                      decoration: const ShapeDecoration(
                                        color: Color(0xFFF53F57),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                    Text(
                                      LocaleKeys.follow206.tr,
                                      style: AppTextStyle.f_12_500.color999999,
                                    ),
                                  ],
                                )
                              : Text(
                                  controller.orderHistoryShow!,
                                  style: AppTextStyle.f_12_500.color999999,
                                ),
                          SizedBox(width: 4.w),
                          MyImage(
                            'default/go'.svgAssets(),
                            width: 12.w,
                            color: AppColor.color4D4D4D,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      showGrabOrderDisplaySheetView(
                          controller.grabOrderDisplayList,
                          controller.orderHistoryShowIndex,
                          1);
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      // color: Colors.amber,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 14.w),
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.follow124.tr,
                            style: AppTextStyle.f_14_500.color666666,
                          ),
                          const Spacer(),
                          controller.orderFollowShow == null
                              ? Row(
                                  children: [
                                    Container(
                                      width: 4.w,
                                      height: 4.w,
                                      margin: EdgeInsets.only(right: 4.w),
                                      decoration: const ShapeDecoration(
                                        color: Color(0xFFF53F57),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                    Text(
                                      LocaleKeys.follow206.tr,
                                      style: AppTextStyle.f_12_500.color999999,
                                    ),
                                  ],
                                )
                              : Text(
                                  controller.orderFollowShow!,
                                  style: AppTextStyle.f_12_500.color999999,
                                ),
                          SizedBox(width: 4.w),
                          MyImage(
                            'default/go'.svgAssets(),
                            width: 12.w,
                            color: AppColor.color4D4D4D,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      showGrabOrderDisplaySheetView(
                          controller.grabOrderDisplayList,
                          controller.orderFollowShowIndex,
                          2);
                    },
                  ),
                  // ListTile(
                  //   title: Row(
                  //     children: [
                  //       Text(
                  //         '跟单用户管理',
                  //         style: AppTextStyle.medium_500.color666666,
                  //       ),
                  //       const Spacer(),
                  //       MyImage(
                  //         'default/go'.svgAssets(),
                  //         width: 16.w,
                  //         color: AppColor.color4D4D4D,
                  //       )
                  //     ],
                  //   ),
                  //   onTap: () => Get.toNamed(Routes.MY_TAKE_SHIELD),
                  // ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 14.w, 10.w, 14.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(LocaleKeys.follow207.tr,
                                        style:
                                            AppTextStyle.f_14_500.color666666),
                                    SizedBox(height: 2.h),
                                    Text(LocaleKeys.follow208.tr,
                                        style:
                                            AppTextStyle.f_12_400.color999999),
                                  ],
                                ),
                              ),
                              // const Spacer(),
                              Obx(() => Transform(
                                    transform: Matrix4.identity()
                                      ..scale(0.8, 0.8),
                                    child: CupertinoSwitch(
                                      activeColor: const Color(0xFFFFD428),
                                      value: controller.switchOpen.value,
                                      onChanged: (bool value) {
                                        controller.setSwitch();
                                      },
                                    ),
                                  ))
                            ],
                          ),
                          Obx(() => controller.switchOpen.value
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.MY_TAKE_BLOCK,
                                        arguments: {
                                          'type':
                                              MyTakeShieldActionType.applyFor
                                        });
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 16.h),
                                    padding: EdgeInsets.all(10.w),
                                    decoration: ShapeDecoration(
                                      color: AppColor.colorF5F5F5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6.r)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(LocaleKeys.follow209.tr,
                                            style: AppTextStyle
                                                .f_14_500.color666666),
                                        SizedBox(width: 4.w),
                                        MyImage(
                                          'default/go'.svgAssets(),
                                          width: 12.w,
                                          color: AppColor.color4D4D4D,
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                        ],
                      ),
                    ),
                    onTap: () => Get.toNamed(Routes.MY_TAKE_SHIELD),
                  ),
                ],
              );
            }));
  }

  showGrabOrderDisplaySheetView(List array, num? current, int type) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 21.h),
              ListView.builder(
                shrinkWrap: true,
                itemCount: array.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      controller.setTakePosition(type, index);
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 14.h),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: index == current
                              ? AppColor.colorF5F5F5
                              : Colors.transparent),
                      child: DecoratedBox(
                        decoration:
                            const BoxDecoration(color: Colors.transparent),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              array[index],
                              style: AppTextStyle.f_15_500.color111111,
                            ),
                            index == current
                                ? const Icon(Icons.check)
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 48.w,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(16.w, 16.w, 16.w,
                      16.w + MediaQuery.of(context).padding.bottom),
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(width: 1, color: AppColor.colorABABAB)),
                  child: Text(LocaleKeys.public2.tr,
                      style: AppTextStyle.f_16_600.color111111),
                ),
              ),
            ],
          ),
        );
      },
    );
    // MediaQuery.of(context).padding.bottom
  }
}
