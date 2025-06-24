import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/controllers/my_follow_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

class MyfollowTop extends StatelessWidget {
  const MyfollowTop({
    super.key,
    required this.controller,
  });
  final MyFollowController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Obx(() => Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8.h, bottom: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(LocaleKeys.assets47.tr, style: AppTextStyle.f_12_400.color111111),
                    SizedBox(width: 4.w),
                    Text('(USDT)',
                        style: AppTextStyle.f_12_400.copyWith(
                          color: AppColor.color111111.withOpacity(0.6),
                        )),
                    GestureDetector(
                        onTap: () {
                          controller.changeText();
                        },
                        child: Padding(
                            padding: EdgeInsets.all(4.w),
                            child: controller.isText.value
                                ? MyImage(
                                    'default/eyes_open'.svgAssets(),
                                    width: 12.w,
                                    color: AppColor.colorBBBBBB,
                                  )
                                : MyImage(
                                    'default/eyes_close'.svgAssets(),
                                    width: 12.w,
                                    color: AppColor.colorBBBBBB,
                                  ))),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text(controller.isText.value ? controller.incomeInfo.followAmountStr : '******',
                      style: AppTextStyle.f_24_600.color111111),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 170.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${LocaleKeys.follow187.tr} (USDT)', style: AppTextStyle.f_11_400.color666666),
                          SizedBox(height: 6.w),
                          Text(controller.isText.value ? controller.incomeInfo.incomeAmountStr : '******',
                              style: AppTextStyle.f_12_600.color111111)
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(LocaleKeys.follow188.tr, style: AppTextStyle.f_11_400.color666666),
                        SizedBox(height: 6.w),
                        Text(controller.isText.value ? controller.incomeInfo.incomeRateStr : '******',
                            style: AppTextStyle.f_12_600.copyWith(color: controller.incomeInfo.strColor)),
                      ],
                    )
                  ],
                ),
              ],
            ))));
  }
}

class MyFollowTabbar extends StatelessWidget {
  const MyFollowTabbar({super.key, required this.dataArray, required this.controller});
  final List<String> dataArray;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        // border: Border(
        //   bottom: BorderSide(width: 1.0, color: AppColor.colorF5F5F5),
        // ),
      ),
      height: 40.h,
      width: double.infinity,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.colorABABAB,
        labelColor: AppColor.color111111,
        labelStyle: AppTextStyle.f_14_500,
        unselectedLabelStyle: AppTextStyle.f_14_500,

        // labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp, ),
        // unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp, ),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColor.colorBlack,
            width: 2.h,
          ),
          // insets: EdgeInsets.only(left: 14.w, right: 14.w, top: 0, bottom: 0),
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
    );
  }
}
