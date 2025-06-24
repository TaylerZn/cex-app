import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_apply_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/merchant/controllers/merchant_apply_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/footer_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/withdrawal/index/controllers/withdrawal_index_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/withdrawal/index/views/withdrawal_index_view.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../widgets/dialog/my_bottom_dialog.dart';

class DepositDialog extends StatelessWidget {
  final OtcApplyInfo? applyInfo;
  final int type;
  final MerchantApplyController controller;

  DepositDialog(
      {super.key,
      required this.applyInfo,
      required this.type,
      required this.controller});
  // final controller = Get.find<CustomerApplyController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: AppColor.colorWhite),
      child: type == 1
          ? refundContent()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        19.verticalSpace,
                        Text(LocaleKeys.c2c77.tr, style: AppTextStyle.f_20_600),
                        10.verticalSpace,
                        Text('${applyInfo?.amountStr} USDT',
                            style: AppTextStyle.f_38_600),
                        10.verticalSpace,
                        Row(
                          children: [
                            Text(
                                '${LocaleKeys.c2c86.tr} ${applyInfo?.balance.removeInvalidZero()} USDT',
                                style: AppTextStyle.f_13_400.color666666),
                            InkWell(
                                onTap: () {
                                  Get.back();
                                  Get.toNamed(Routes.ASSETS_TRANSFER,
                                      arguments: {"from": 3, "to": 0});
                                },
                                child: Row(
                                  children: [
                                    4.horizontalSpace,
                                    MyImage(
                                      'otc/c2c/transfer_icon'.svgAssets(),
                                      width: 10.w,
                                      height: 10.h,
                                    )
                                  ],
                                ))
                          ],
                        ),
                        24.verticalSpace,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyImage('otc/c2c/notice_icon'.svgAssets(),
                                width: 12.w, height: 12.h),
                            4.w.horizontalSpace,
                            Expanded(
                                child: Text(LocaleKeys.c2c87.tr,
                                    style: AppTextStyle.f_13_400.color666666))
                          ],
                        ),
                        24.verticalSpace,
                      ],
                    )),
                CustomerFooterWidget(
                    text: LocaleKeys.c2c88.tr,
                    backgroundColor: applyInfo?.enoughBalance == false
                        ? AppColor.colorCCCCCC
                        : AppColor.color111111,
                    onTap: () async {
                      if (applyInfo?.enoughBalance == false) {
                        return;
                      }
                      var data = await showMyBottomDialog(
                          Get.context,
                          const MySafeC2CWithdrawal(
                            verifCount: 1,
                            c2cStyle: true,
                          ),
                          padding: EdgeInsets.fromLTRB(24.w, 34.h, 24.w, 16.h),
                          isDismissible: false);
                      Get.delete<MySafeC2CWithdrawallController>();
                      if (ObjectUtil.isEmpty(data)) {
                        Get.back();
                        return;
                      }
                      dynamic response =
                          await controller.reqDepositPayment(data);
                      if (response == null) {
                        Get.back();
                      }
                    })
              ],
            ),
    );
  }

  Widget refundContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                19.verticalSpace,
                Text(LocaleKeys.c2c85.tr, style: AppTextStyle.f_20_600),
                10.verticalSpace,
                Text('${applyInfo?.amountStr} USDT',
                    style: AppTextStyle.f_38_600),
                24.verticalSpace,
                Row(
                  children: [
                    MyImage('otc/c2c/notice_icon'.svgAssets(),
                        width: 10.w, height: 10.h),
                    4.w.horizontalSpace,
                    Expanded(
                        child: Text(LocaleKeys.c2c90.tr,
                            style: AppTextStyle.f_14_400.color666666)),
                  ],
                ),
                24.verticalSpace,
              ],
            )),
        CustomerFooterWidget(
            text: LocaleKeys.c2c89.tr,
            backgroundColor: AppColor.color111111,
            onTap: () async {
              var data = await showMyBottomDialog(
                  Get.context,
                  const MySafeC2CWithdrawal(
                    verifCount: 1,
                    c2cStyle: true,
                  ),
                  padding: EdgeInsets.fromLTRB(24.w, 34.h, 24.w, 16.h),
                  isDismissible: false);
              Get.delete<MySafeC2CWithdrawallController>();
              if (ObjectUtil.isEmpty(data)) {
                Get.back();
                return;
              }
              if (await controller.reqRefundPayment(data) == null) {
                Get.back();
              }
            })
      ],
    );
  }
}
