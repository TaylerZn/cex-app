import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CommunitySubTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> titles;

  // Modify the constructor to remove default values for titles
  const CommunitySubTabBar(
      {Key? key, required this.controller, required this.titles})
      : super(key: key);

  // Add a factory constructor to handle default titles
  factory CommunitySubTabBar.withDefaultTitles(
      {Key? key,
      required TabController controller,
      required BuildContext context}) {
    return CommunitySubTabBar(
      key: key,
      controller: controller,
      titles: [LocaleKeys.community42.tr, LocaleKeys.community43.tr],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      unselectedLabelColor: AppColor.colorABABAB,
      labelColor: AppColor.color111111,
      labelStyle: AppTextStyle.f_16_500,
      padding: EdgeInsets.only(right: 16.w),
      unselectedLabelStyle: AppTextStyle.f_16_500,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: AppColor.colorBlack,
          width: 2.h,
        ),
      ),
      labelPadding: EdgeInsets.only(left: 16.w, right: 4.w, top: 0, bottom: 0),
      tabs: titles
          .map((title) => Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(title),
                ),
              ))
          .toList(),
    );
  }
}
