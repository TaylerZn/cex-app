import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/user.dart';
import 'package:nt_app_flutter/app/modules/my/widgets/Kyc_Info_Page.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/my_out_line_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../getX/user_Getx.dart';

class KYCCheckDialog extends StatefulWidget {
  const KYCCheckDialog({super.key});

  @override
  State<KYCCheckDialog> createState() => _KYCCheckDialogState();
}

class _KYCCheckDialogState extends State<KYCCheckDialog> {
  final ValueNotifier<int> counter = ValueNotifier<int>(0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIndex();
  }

  void checkIndex() {
    counter.value = 0;
    if (UserGetx.to.isKyc) {
      counter.value = counter.value + 1;
    }
    if (mobileVerified) {
      counter.value = counter.value + 1;
    }
  }

  bool get mobileVerified =>
      UserGetx.to.isGoogleVerify || UserGetx.to.isMobileVerify;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.colorWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r))),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    34.h.verticalSpace,
                    Text(LocaleKeys.c2c91.tr, style: AppTextStyle.f_24_600),
                    6.h.verticalSpace,
                    Text(LocaleKeys.c2c92.tr,
                        style: AppTextStyle.f_12_500.color999999),
                    20.verticalSpace,
                    ValueListenableBuilder(
                        valueListenable: counter,
                        builder: (_, value, __) =>
                            Text('${value}/2', style: AppTextStyle.f_28_600)),
                    28.verticalSpace,
                    InkWell(
                        onTap: () async {
                          if (UserGetx.to.getAuthStatus == UserAuditStatus.noSubmit) {
                            await Get.toNamed(Routes.KYC_INDEX,
                                preventDuplicates: false);
                          } else {
                            Get.to(KycInfoPage());
                          }
                          EasyLoading.show();
                          await UserGetx.to.getRefresh();
                          EasyLoading.dismiss();
                          checkIndex();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 26.h),
                            decoration: BoxDecoration(
                                color: UserGetx.to.isKyc
                                    ? AppColor.colorF5F5F5
                                    : AppColor.colorFFFFFF,
                                borderRadius: UserGetx.to.isKyc
                                    ? null
                                    : BorderRadius.all(Radius.circular(6.r)),
                                border: Border.all(color: AppColor.colorECECEC)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('KYC认证', style: AppTextStyle.f_16_600),
                                buildKycIndicator()
                              ],
                            ))),
                    20.verticalSpace,
                    InkWell(
                        onTap: () async {
                          await Get.toNamed(Routes.MY_SAFE_GOOGLE,
                              preventDuplicates: false);
                          await UserGetx.to.getRefresh();
                          setState(() {});
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 26.h),
                            decoration: BoxDecoration(
                                color: mobileVerified
                                    ? AppColor.colorF5F5F5
                                    : AppColor.colorFFFFFF,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.r)),
                                border: mobileVerified
                                    ? null
                                    : Border.all(color: AppColor.colorECECEC)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(LocaleKeys.c2c93.tr,
                                    style: AppTextStyle.f_16_600),
                                mobileVerified
                                    ? MyImage(
                                        'otc/c2c/selected_icon'.svgAssets(),
                                        width: 16.w,
                                        height: 16.w,
                                      )
                                    : Row(
                                        children: [
                                          Text('*${LocaleKeys.user103.tr}',
                                              style: AppTextStyle
                                                  .f_14_500.colorABABAB),
                                          4.w.horizontalSpace,
                                          MyImage(
                                              'otc/c2c/right_arrow'.svgAssets())
                                        ],
                                      )
                              ],
                            ))),
                  ],
                )),
            16.verticalSpace,
            Container(
              height: 1.h,
              color: AppColor.colorECECEC,
            ),
            MyOutLineButton(
                width: 343.w,
                height: 48.h,
                onTap: () {
                  Get.back();
                },
                title: LocaleKeys.trade210.tr).marginSymmetric(vertical: 16.w),
          ],
        ),
      ),
    );
  }

  Widget buildKycIndicator() {
    switch (UserGetx.to.getAuthStatus) {
      case UserAuditStatus.Success:
        return MyImage(
          'otc/c2c/selected_icon'.svgAssets(),
          width: 16.w,
          height: 16.w,
        );
      case UserAuditStatus.Reviewing:
        return Text(LocaleKeys.user102.tr,
            style: AppTextStyle.f_14_500.colorABABAB);
      default:
        return Row(
          children: [
            Text('*${LocaleKeys.user103.tr}',
                style: AppTextStyle.f_14_500.colorABABAB),
            4.w.horizontalSpace,
            MyImage('otc/c2c/right_arrow'.svgAssets())
          ],
        );
    }
  }
}
