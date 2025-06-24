import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../config/theme/app_color.dart';
import '../../../config/theme/app_text_style.dart';
import '../../../widgets/basic/my_button.dart';

class FollowWidget extends StatelessWidget {
  final bool isFollow;
  final VoidCallback onTap;

  const FollowWidget({super.key, required this.isFollow, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 28.w,
        child: MyButton(
          padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 13.w),
          color: isFollow ? AppColor.color111111 : AppColor.colorTextPrimary,
          borderRadius: BorderRadius.circular(60.r),
          textStyle: AppTextStyle.f_13_500,
          backgroundColor: isFollow
              ? AppColor.colorF5F5F5
              : AppColor.colorBackgroundSecondary,
          text: isFollow
              ? LocaleKeys.community111.tr //'正在关注'
              : LocaleKeys.community43.tr,
          //'关注',
          onTap: onTap,
        ));
  }
}
