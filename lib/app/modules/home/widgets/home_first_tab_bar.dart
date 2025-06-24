import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class HomeFirstTabBar extends StatelessWidget {
  const HomeFirstTabBar({
    super.key,
    required this.dataArray,
    required this.controller,
  });

  final List<String> dataArray;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        height: 36.w,
        child: TabBar(
          controller: controller,
          isScrollable: true,
          unselectedLabelColor: AppColor.colorTextDisabled,
          unselectedLabelStyle: AppTextStyle.f_15_500,
          labelColor: AppColor.colorTextPrimary,
          labelStyle: AppTextStyle.f_15_600,
          labelPadding: EdgeInsets.only(left: 16.w),
          indicator: const BoxDecoration(),
          tabs: dataArray
              .map((f) => Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(f),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
