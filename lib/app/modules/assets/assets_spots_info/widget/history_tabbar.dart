import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';

//

class HistoryTabbar extends StatelessWidget {
  const HistoryTabbar(
      {super.key,
      required this.dataArray,
      required this.controller,
      this.height = 26,
      this.marginTop = 0,
      this.marginBottom = 4,
      this.radius = 4,
      this.unselectedLabelStyle,
      this.labelStyle});
  final List<String> dataArray;
  final TabController controller;
  final double height;
  final double marginTop;
  final double marginBottom;
  final double radius;
  final TextStyle? unselectedLabelStyle;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorWhite,
      // color: Colors.red,
      padding: EdgeInsets.fromLTRB(8.w, marginTop.h, 16.w, marginBottom.h),
      alignment: Alignment.centerLeft,
      height: (height + marginTop + marginBottom).h,
      child: TabBar(
        controller: controller,
        isScrollable: true,
        unselectedLabelColor: AppColor.colorABABAB,
        labelColor: AppColor.color111111,
        labelStyle: labelStyle ?? AppTextStyle.f_12_500,
        unselectedLabelStyle: unselectedLabelStyle ?? AppTextStyle.f_10_500,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding:
            EdgeInsets.only(left: 8, right: 8, top: 0.h, bottom: 0.h),
        labelPadding:
            EdgeInsets.only(left: 16.w, right: 16.w, top: 6.h, bottom: 6),
        tabAlignment: TabAlignment.start,
        indicator: ShapeDecoration(
            color: AppColor.colorF5F5F5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius.r),
            )),
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
