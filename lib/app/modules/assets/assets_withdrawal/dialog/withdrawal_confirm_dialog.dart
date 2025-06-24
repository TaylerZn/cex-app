import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/assets/assets_api.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/safe.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_withdrawal/dialog/ver_input_widget.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../models/assets/assets_withdraw_result.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/utilities/ui_util.dart';

class AssetsWithdrawalConfirmDialog extends StatefulWidget {
  final String currency;
  final String network;
  final String address;
  final String amount;
  final String defaultFee;
  final String receiveAmount;
  const AssetsWithdrawalConfirmDialog(
      {super.key,
      required this.receiveAmount,
      required this.currency,
      required this.defaultFee,
      required this.network,
      required this.address,
      required this.amount});

  @override
  State<AssetsWithdrawalConfirmDialog> createState() =>
      _AssetsWithdrawalConfirmDialogState();
}

class _AssetsWithdrawalConfirmDialogState
    extends State<AssetsWithdrawalConfirmDialog> {
  String smsCode = '';
  String emailCode = '';
  String googleCode = '';
  int current = 0;
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return current == 0 ? normalContent() : confimContent();
  }

  Widget normalContent() {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: MyImage(
                'default/close'.svgAssets(),
                fit: BoxFit.fill,
                width: 16.w,
                height: 16.w,
              ),
            )),
        MyImage('assets/board'.svgAssets()),
        12.verticalSpaceFromWidth,
        Text(LocaleKeys.assets181.tr, style: AppTextStyle.f_24_600.color111111),
        12.verticalSpaceFromWidth,
        Text(
          LocaleKeys.assets182.tr,
          style: AppTextStyle.f_13_400.color4D4D4D,
          textAlign: TextAlign.center,
        ),
        16.verticalSpaceFromWidth,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
          decoration: BoxDecoration(
              color: AppColor.colorBackgroundSecondary,
              borderRadius: BorderRadius.all(Radius.circular(8.r))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyImage('assets/yel_notice'.svgAssets()).marginOnly(top: 4.w),
              10.horizontalSpace,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocaleKeys.assets183.tr,
                      style: AppTextStyle.f_14_600.colorTextPrimary),
                  8.verticalSpaceFromWidth,
                  Text(LocaleKeys.assets184.tr,
                      style: AppTextStyle.f_12_400.colorTextDescription)
                ],
              ))
            ],
          ),
        ),
        16.verticalSpaceFromWidth,
        InkWell(
          onTap: () {
            setState(() {
              isCheck = !isCheck;
            });
          },
          child: Row(
            children: [
              MyImage(
                isCheck
                    ? 'assets/check'.pngAssets()
                    : 'assets/not_check'.svgAssets(),
                width: 12.w,
                height: 12.w,
              ).marginOnly(right: 4.w),
              Text(LocaleKeys.assets185.tr,
                  style: AppTextStyle.f_12_400.color4D4D4D)
            ],
          ),
        ),
        40.verticalSpaceFromWidth,
        MyButton(
            width: double.infinity,
            height: 48.w,
            color: isCheck ? AppColor.colorWhite : AppColor.colorTextDisabled,
            backgroundColor: isCheck
                ? AppColor.color111111
                : AppColor.colorBackgroundTertiary,
            borderRadius: BorderRadius.all(Radius.circular(60.r)),
            text: LocaleKeys.assets186.tr,
            onTap: () async {
              if (isCheck) {
                setState(() {
                  current = 1;
                });
              }
            })
      ],
    );
  }

  Widget confimContent() {
    Widget buildItem(String title, String value) {
      return SizedBox(
        height: 40.w,
        child: Row(
          children: [
            Expanded(
                child: Text(title,
                    style: AppTextStyle.f_13_400.colorTextDescription)),
            Expanded(
                child: Container(
              alignment: Alignment.centerRight,
              child: Text(value, style: AppTextStyle.f_13_600.colorTextPrimary),
            )),
          ],
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
            height: 27.w,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Text(LocaleKeys.assets187.tr,
                        style: AppTextStyle.f_18_600.color111111)),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: MyImage(
                        'default/close'.svgAssets(),
                        fit: BoxFit.fill,
                        width: 16.w,
                        height: 16.w,
                      ),
                    ))
              ],
            )),
        12.verticalSpaceFromWidth,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
          decoration: BoxDecoration(
              color: AppColor.colorBackgroundSecondary,
              borderRadius: BorderRadius.all(Radius.circular(8.r))),
          child: Row(
            children: [
              MyImage('assets/yel_notice'.svgAssets()),
              10.horizontalSpace,
              Text(LocaleKeys.assets188.tr,
                  style: AppTextStyle.f_13_400.color4D4D4D)
            ],
          ),
        ),
        16.verticalSpaceFromWidth,
        buildItem(LocaleKeys.assets179.tr, widget.network),
        buildItem(LocaleKeys.assets89.tr, widget.address),
        buildItem(
            LocaleKeys.assets190.tr, '${widget.amount} ${widget.currency}'),
        buildItem(
            LocaleKeys.assets178.tr, '${widget.defaultFee} ${widget.currency}'),
        buildItem(LocaleKeys.assets177.tr, '${widget.receiveAmount}'),
        buildVerSection(),
        40.verticalSpaceFromWidth,
        MyButton(
            width: double.infinity,
            height: 48.w,
            borderRadius: BorderRadius.all(Radius.circular(60.r)),
            text: LocaleKeys.public3.tr,
            onTap: () async {
              withdraw();
            })
      ],
    );
  }

  Widget buildVerSection() {
    return Column(
      children: [
        Visibility(
            visible: UserGetx.to.isSetEmail,
            child: Container(
              margin: EdgeInsets.only(top: 16.w),
              child: VerifInputWidget(
                  type: UserSafeVerificationEnum.EMAIL_CRYTO_WITHDRAW,
                  onChanged: (value) {
                    emailCode = value;
                  }),
            )),
        Visibility(
            visible: UserGetx.to.isMobileVerify,
            child: Container(
              margin: EdgeInsets.only(top: 16.w),
              child: VerifInputWidget(
                  type: UserSafeVerificationEnum.MOBILE_CRYTO_WITHDRAW,
                  onChanged: (value) {
                    smsCode = value;
                  }),
            )),
        Visibility(
          visible: UserGetx.to.isGoogleVerify,
          child: Container(
              margin: EdgeInsets.only(top: 16.w),
              child: VerifInputWidget(
                  type: UserSafeVerificationEnum.CLOSE_GOOGLE_VALID,
                  onChanged: (value) {
                    googleCode = value;
                  })),
        )
      ],
    );
  }

  void withdraw() async {
    List<String> list = [emailCode, smsCode, googleCode];
    if (list.where((element) => ObjectUtil.isNotEmpty(element)).length < 2) {
      UIUtil.showToast(LocaleKeys.assets191.tr);
      return;
    }

    try {
      EasyLoading.show();
      final AssetsWithdrawResult res = await AssetsApi.instance().doWithdraw(
          widget.currency,
          widget.amount,
          widget.address,
          smsCode,
          googleCode,
          emailCode,
          widget.network);
      EasyLoading.dismiss();

      var arguments = {
        'currency': widget.currency,
        'amount': widget.amount,
      };
      AssetsGetx.to.getRefresh();
      Get.offNamed(Routes.ASSETS_WITHDRAWAL_RESULT, arguments: arguments);
    } on DioException catch (e) {
      Get.log('withdraw error: $e');
      UIUtil.showError(e.error);
    }
  }
}
