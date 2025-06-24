import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class MyToast extends StatelessWidget {
  final String img;
  final String msg;

  const MyToast({super.key, required this.img, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: AppColor.colorWhite,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 6),
              blurRadius: 24, //阴影范围
              spreadRadius: 0, //阴影浓度
              color: AppColor.colorBlack.withOpacity(0.08), //阴影颜色
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyImage(
            img,
            width: 28.w,
          ),
          16.horizontalSpace,
          Expanded(
              child: Text(
            ObjectUtil.isEmptyString(msg) ? '？' : msg,
            style: AppTextStyle.f_16_500.color111111,
            maxLines: 3,
          ))
        ],
      ),
    );
  }
}
