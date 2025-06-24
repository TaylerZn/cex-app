import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';

import '../../../../config/theme/app_color.dart';

class CommodityTabbar extends StatelessWidget {
  const CommodityTabbar(
      {super.key, required this.dataArray, required this.controller});

  final List<String> dataArray;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      height: 46.h,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.colorTextDisabled,
        labelColor: AppColor.colorTextPrimary,
        labelStyle: AppTextStyle.f_12_400,
        unselectedLabelStyle: AppTextStyle.f_12_400,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding:
            EdgeInsets.only(left: 0, right: 0, top: 12.h, bottom: 12.h),
        labelPadding:
            const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 0),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColor.colorBackgroundTertiary,
        ),
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
