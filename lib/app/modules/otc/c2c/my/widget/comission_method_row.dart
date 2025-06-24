import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_list.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../../../../models/otc/c2c/payment_info.dart';

class ComissionMethodRow extends StatelessWidget {
  final PaymentInfo? paymentInfo;
  final Function(int)? onTap;

  const ComissionMethodRow({super.key, required this.paymentInfo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('otc/c2c/card_bg'.pngAssets())),
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
          border: Border.all(color: AppColor.colorF5F5F5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.h.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomerPayview(
                  name: paymentInfo?.payment ?? '',
                  title: ' ${paymentInfo?.paymentTitle}',
                  width: 4.w,
                  height: 10.h,
                  style: AppTextStyle.f_14_400.colorWhite),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          onTap?.call(0);
                        },
                        child: MyImage(
                          'otc/c2c/bank_edit'.svgAssets(),
                          width: 14.w,
                        ),
                      ),
                      24.w.horizontalSpace,
                      InkWell(
                          onTap: () {
                            onTap?.call(1);
                          },
                          child: MyImage('otc/c2c/bank_delete'.svgAssets(),
                              width: 14.w))
                    ],
                  )
                ],
              )
            ],
          ),
          20.h.verticalSpace,
          Text('${paymentInfo?.userName}',
              style: AppTextStyle.f_12_400.colorWhite),
          4.h.verticalSpace,
          Text(paymentInfo?.cryptoAccount ?? '-',
              style: AppTextStyle.f_20_600.colorWhite),
          4.h.verticalSpace,
          Text(paymentInfo?.bankName ?? '-',
              style: AppTextStyle.f_12_400.colorABABAB),
        ],
      ),
    );
  }
}
