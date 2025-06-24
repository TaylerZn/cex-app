import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/dialog/my_share_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../config/theme/app_color.dart';
import '../../../getX/user_Getx.dart';

class ShareKChartDetailView extends StatelessWidget {
  const ShareKChartDetailView({super.key, required this.image});

  final Uint8List image;

  static show({required Uint8List image}) {
    Get.dialog(ShareKChartDetailView(image: image), useSafeArea: false);
  }

  @override
  Widget build(BuildContext context) {
    return MyShareView(
      content: _buildContent(),
      url: UserGetx.to.user?.info?.inviteUrl ?? '',
    );
  }

  Widget _buildContent() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        color: AppColor.bgColorDark,
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyImage(
              'assets/images/contract/share_k_logo.svg',
              width: 112.w,
              height: 30.h,
            ),
            20.verticalSpace,
            // 显示 image
            Image.memory(
              image,
              width: Get.width - 64.w,
            ),
            // 16.verticalSpace,
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/contract/share_kchart_bottom.png',
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
              width: 313.w,
              height: 84.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: QrImageView(
                      data: UserGetx.to.user?.info?.inviteUrl ?? '',
                      version: QrVersions.auto,
                      size: 52.w,
                      backgroundColor: AppColor.colorWhite,
                      padding: const EdgeInsets.all(2),
                    ),
                  ),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.trade268.tr,
                        style: AppTextStyle.f_10_500.color999999,
                      ),
                      2.verticalSpace,
                      Text(
                        'BITCOCO app',
                        style: AppTextStyle.f_14_400.colorWhite,
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        LocaleKeys.trade269.tr,
                        style: AppTextStyle.f_10_500.color999999,
                      ),
                      4.verticalSpace,
                      Text(
                        UserGetx.to.user?.info?.inviteCode ?? '',
                        style: AppTextStyle.f_14_400.colorWhite,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
