import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../widgets/components/transaction/count_down_widget.dart';

class CloseMarketButton extends StatelessWidget {
  const CloseMarketButton(
      {super.key, required this.endTime, required this.stopCallback});

  final int endTime;
  final VoidCallback stopCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: AppColor.color111111, width: 1),
      ),
      child: Column(
        children: [
          Text(
            LocaleKeys.trade14.tr,
            style: AppTextStyle.f_14_500.copyWith(
              color: AppColor.color333333,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountDownWidget(
                endTime: endTime,
                stopCallback: stopCallback,
              ),
              4.horizontalSpace,
              Text(
                LocaleKeys.trade15.tr,
                style: AppTextStyle.f_11_400.copyWith(
                  color: AppColor.color666666,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
