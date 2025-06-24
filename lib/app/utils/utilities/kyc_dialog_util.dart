
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';

import '../../../generated/locales.g.dart';
import '../../config/theme/app_color.dart';
import '../../config/theme/app_text_style.dart';
import '../../enums/user.dart';
import '../../getX/user_Getx.dart';
import '../../modules/my/widgets/Kyc_Info_Page.dart';
import '../../routes/app_pages.dart';
import '../../widgets/basic/my_image.dart';

class KycDialogUtil {
  static void showKycDialog({String? title}) {
    UIUtil.showAlert(title ?? LocaleKeys.user309.tr,
        isDismissible: true,
        content:  LocaleKeys.user310.tr,
        contentWidget: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 16.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            color: AppColor.colorEEEEEE,
          ),
          child: Row(
            children: [
              MyImage(
                'my/setting/kyc_go_small'.svgAssets(),
                color: AppColor.color666666,
              ),
              8.horizontalSpace,
              Expanded(
                  child: Text(
                    LocaleKeys.user311.tr,
                    style: AppTextStyle.f_14_500.color666666,
                  ))
            ],
          ),
        ),
        confirmText: LocaleKeys.user312.tr, confirmHandler: () {
          Get.back();
          if (UserGetx.to.getAuthStatus == UserAuditStatus.noSubmit) {
            Get.toNamed(Routes.KYC_INDEX);
          } else {
            Get.to(KycInfoPage());
          }
        });
  }
}