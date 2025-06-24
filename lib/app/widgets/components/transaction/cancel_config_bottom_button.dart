import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../config/theme/app_color.dart';

class CancelConfirmBottomButton extends StatelessWidget {
  const CancelConfirmBottomButton(
      {super.key, required this.onCancel, required this.onConfirm});
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MyButton(
            text: LocaleKeys.public2.tr,
            onTap: onCancel,
            backgroundColor: AppColor.colorAlwaysWhite,
            color: AppColor.colorTextPrimary,
            height: 48.h,
            border: Border.all(
              color: AppColor.colorBorderStrong,
            ),
          ),
        ),
        7.horizontalSpace,
        Expanded(
          child: MyButton(
            text: LocaleKeys.public1.tr,
            onTap: onConfirm,
            color: AppColor.colorAlwaysWhite,
            height: 48.h,
            border: Border.all(
              color: AppColor.colorBorderStrong,
            ),
          ),
        ),
      ],
    );
  }
}
