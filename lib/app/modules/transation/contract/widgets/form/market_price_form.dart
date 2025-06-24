import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MarketPriceForm extends StatelessWidget {
  const MarketPriceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: AppColor.colorD9D9D9,
        borderRadius: BorderRadius.circular(6.r),
      ),
      alignment: Alignment.center,
      child: Text(
        LocaleKeys.trade74.tr,
        style: AppTextStyle.f_14_600.copyWith(
          color: AppColor.color999999,
        ),
      ),
    );
  }
}
