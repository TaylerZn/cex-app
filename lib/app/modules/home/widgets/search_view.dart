import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class SearchView extends StatelessWidget {
  final Color? searchIconColor;
  final Color? backgroundColor;

  const SearchView(
      {super.key, this.searchIconColor = AppColor.colorTextTips, this.backgroundColor = AppColor.colorBackgroundInput});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: backgroundColor,
      ),
      child: Row(
        children: [
          12.horizontalSpace,
          MyImage(
            'assets/images/trade/search_icon.svg',
            width: 16.w,
            height: 16.w,
            color: searchIconColor,
          ),
          8.horizontalSpace,
          Expanded(
            child: Text(
              LocaleKeys.public11.tr,
              style: AppTextStyle.f_13_400.colorTextDisabled,
            ),
          ),
        ],
      ),
    );
  }
}
