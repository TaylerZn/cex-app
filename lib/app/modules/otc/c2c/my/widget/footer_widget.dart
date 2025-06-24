import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:vm_service/vm_service.dart';

class CustomerFooterWidget extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? titleColor;
  final Color? boderColor;
  final String? text;
  final Function? onTap;
  const CustomerFooterWidget(
      {super.key,
      this.text,
      this.onTap,
      this.backgroundColor,
      this.boderColor,
      this.titleColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 110.h,
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(width: double.infinity,height: 1.h,color: AppColor.colorEEEEEE),
          SizedBox(height: 16.h),
          Padding(padding: EdgeInsets.symmetric(horizontal: 24.w),child: MyButton(
              backgroundColor: backgroundColor ?? AppColor.color111111,
              width: double.infinity,
              text: text ?? '---',
              height: 48.h,
              color: titleColor ?? AppColor.colorWhite,
              border: Border.all(color: boderColor ?? Colors.transparent),
              goIcon: true,
              goIconColor: iconColor,
              onTap: () {
                onTap?.call();
              }))
        ],
      ),
    );
  }
}
