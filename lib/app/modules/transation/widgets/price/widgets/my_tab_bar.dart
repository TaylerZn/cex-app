import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar(
      {super.key, required this.onValueChanged, required this.currentIndex});

  final ValueChanged<int> onValueChanged;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        border: const Border(
          bottom: BorderSide(
            color: AppColor.colorBorderGutter,
            width: 0.5,
          ),
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          _buildTabItem(LocaleKeys.trade197.tr, currentIndex == 0, () {
            onValueChanged(0);
          }),
          24.horizontalSpace,
          _buildTabItem(LocaleKeys.trade188.tr, currentIndex == 1, () {
            onValueChanged(1);
          }),
          24.horizontalSpace,
          _buildTabItem(LocaleKeys.trade198.tr, currentIndex == 2, () {
            onValueChanged(2);
          }),
        ],
      ),
    );
  }

  _buildTabItem(String title, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 38.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: selected ? AppColor.colorBlack : Colors.transparent,
                width: 2.w),
          ),
        ),
        child: Text(
          title,
          style: AppTextStyle.f_14_500.copyWith(
            color: selected ? AppColor.color111111 : AppColor.color999999,
          ),
        ),
      ),
    );
  }
}
