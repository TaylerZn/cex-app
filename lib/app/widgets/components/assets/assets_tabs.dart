import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_tab_underline_widget.dart';

class AssetsTabs extends StatelessWidget {
  final List<String> list;
  final TabController controller;
  final double? gap;
  final double? left;
  final double? fontSize;
  final Color? tabColor;

  const AssetsTabs({super.key, required this.list, required this.controller, this.fontSize, this.gap, this.left, this.tabColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: left ?? 16.w),
      height: 38.h,
      child: TabBar(
        labelPadding: EdgeInsets.only(right: gap ?? 30.w),
        isScrollable: true,
        labelColor: AppColor.color111111,
        unselectedLabelColor: AppColor.colorABABAB,
        controller: controller,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: fontSize ?? 16.sp,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: fontSize ?? 16.sp,
        ),
        indicator: MyUnderlineTabIndicator(
          borderSide: BorderSide(width: 2.h, color: tabColor ?? AppColor.color111111),
        ),
        tabs: list
            .map((e) => Tab(
                  text: e.tr,
                ))
            .toList(),
      ),
    );
  }
}
