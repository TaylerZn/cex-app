import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';

class AssetsAction extends StatelessWidget {
  final List<String> list;
  final Function onTap;
  final double? height;
  final BorderRadius? borderRadius;
  final bool newStyle;
  const AssetsAction(
      {super.key,
      required this.list,
      this.newStyle = false,
      required this.onTap,
      this.height,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    list.asMap().forEach((index, item) {
      if (index == 0) {
        children.add(Expanded(
            child: MyButton(
          backgroundColor: Colors.black,
          height: height ?? 40.h,
          borderRadius: borderRadius,
          onTap: () => {onTap(index)},
          child: Text(item.tr,
              style: newStyle
                  ? AppTextStyle.f_14_600.colorWhite
                  : AppTextStyle.f_15_600.colorWhite),
        )));
      } else {
        children.add(SizedBox(
          width: 10.w,
        ));
        children.add(Expanded(
            child: MyButton(
          borderRadius: borderRadius,
          backgroundColor: AppColor.colorF5F5F5,
          height: height ?? 40.h,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          onTap: () => {onTap(index)},
          child: Text(item.tr,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: newStyle
                  ? AppTextStyle.f_14_600.color111111
                  : AppTextStyle.f_15_600.color111111),
        )));
      }
    });
    return Row(children: children);
  }
}
