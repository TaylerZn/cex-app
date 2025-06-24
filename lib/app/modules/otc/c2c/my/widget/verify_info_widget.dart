import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

import '../../../../../../generated/locales.g.dart';
import '../../../../../models/otc/c2c/otc_user_info.dart';

class VerifyInfoWidget extends StatelessWidget {
  OtcUserInfo? userInfo;

  List<Widget> children = [];
  VerifyInfoWidget({super.key, required this.userInfo});

  Widget buildContent(String title) {
    return Row(
      children: [
        Text(title, style: AppTextStyle.f_10_400.color4D4D4D),
        4.horizontalSpace,
        MyImage('otc/c2c/filled_icon'.svgAssets(), width: 10.w),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userInfo?.idCardStatus == true) {
      children.add(buildContent(LocaleKeys.c2c2.tr));
      children.add(SizedBox(width: 20.w));
    }

    if (userInfo?.phoneStatus == true) {
      children.add(buildContent(LocaleKeys.c2c159.tr));
      children.add(SizedBox(width: 20.w));
    }

    if (userInfo?.emailStatus == true) {
      children.add(buildContent(LocaleKeys.c2c160.tr));
      children.add(SizedBox(width: 20.w));
    }

    return Column(
      children: [
        Visibility(
            visible: userInfo?.isMerchant == true,
            child: Column(
              children: [
                Row(
                  children: [
                    MyImage(
                      'otc/c2c/verify_emblem'.svgAssets(),
                      width: 10.w,
                      height: 10.w,
                    ),
                    2.horizontalSpace,
                    Text(LocaleKeys.c2c1.tr,
                        style: AppTextStyle.f_10_400.color4D4D4D),
                    10.w.horizontalSpace,
                    Text('|', style: AppTextStyle.f_10_400.colorBBBBBB),
                    10.w.horizontalSpace,
                    Text(
                        '${LocaleKeys.c2c3.tr} ${userInfo?.merchant?.marginAmount?.toThousands()} USDT ',
                        style: AppTextStyle.f_10_400.color4D4D4D),
                    MyImage('otc/c2c/notice_outline'.svgAssets(),
                        width: 10.w, height: 10.h),
                  ],
                ),
                16.h.verticalSpace,
              ],
            )),
        Row(
          children: children,
        )
      ],
    );
  }
}
