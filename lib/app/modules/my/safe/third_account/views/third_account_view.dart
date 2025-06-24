import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/universal_large_list.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/third_account_controller.dart';

class ThirdAccountView extends GetView<ThirdAccountController> {
  const ThirdAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyPageBackWidget(),
        centerTitle: true,
        title: Text(LocaleKeys.user164.tr,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
        elevation: 0,
        toolbarHeight: 44.w,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.verticalSpace,
            Text(
              LocaleKeys.user342.tr,
              style: AppTextStyle.f_18_500.color0C0D0F,
            ),
            8.verticalSpace,
            Text(
              LocaleKeys.user343.tr,
              style: AppTextStyle.f_14_400.color8E8E92,
            ),
            22.verticalSpace,
            Obx(
              () => universalLargeListWidget(
                context,
                controller.entriesOne,
                paddingHorizontal: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
