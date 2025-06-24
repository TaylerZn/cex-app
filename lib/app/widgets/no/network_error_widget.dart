import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyImage(
            'default/network_error'.svgAssets(),
            width: 83.w,
            height: 68.h,
          ),
          4.verticalSpace,
          Text(
            LocaleKeys.public59.tr,
            style: AppTextStyle.f_12_400.color999999,
          ),
          24.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: onTap,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      width: 1,
                      color: AppColor.bgColorDark,
                    ),
                  ),
                  child: Text(
                    LocaleKeys.public60.tr,
                    style: AppTextStyle.f_14_400.color111111,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
