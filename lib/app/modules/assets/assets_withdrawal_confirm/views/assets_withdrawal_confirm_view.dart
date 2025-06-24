import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/assets_withdrawal_confirm_controller.dart';

class AssetsWithdrawalConfirmView
    extends GetView<AssetsWithdrawalConfirmController> {
  const AssetsWithdrawalConfirmView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssetsWithdrawalConfirmController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            leading: const MyPageBackWidget(),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                _buildItems(context),
                // _buildTip(context),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 80.w + MediaQuery.of(context).padding.bottom,
            padding: EdgeInsets.fromLTRB(
                24.w, 16.h, 24.w, 16.h + MediaQuery.of(context).padding.bottom),
            child: MyButton(
                height: 48.h,
                text: LocaleKeys.public1.tr,
                color: Colors.white,
                backgroundColor: AppColor.color111111,
                goIcon: true,
                onTap: () async {
                  // Get.to(main_keyboard());

                  // Bus.getInstance().emit(EventType.withdraw);
                  // Get.back();
                  controller.withdraw();
                }),
          ));
    });
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 1.w, color: AppColor.colorEEEEEE))),
      child: Column(
        children: [
          30.verticalSpace,
          Text(
            LocaleKeys.assets88.tr,
            style: AppTextStyle.f_12_500.color666666,
          ),
          2.verticalSpace,
          Text('${'${Decimal.parse(controller.amount) - Decimal.parse(controller.defaultFee)}'} ${controller.currency}',
                  style: AppTextStyle.f_28_600.color111111)
              .paddingSymmetric(horizontal: 24.w),
          2.verticalSpace,
          Text(
            "≈${NumberUtil.mConvert(Decimal.parse(controller.amount) - Decimal.parse(controller.defaultFee), isEyeHide: false, isRate: IsRateEnum.usdt)}",
            style: AppTextStyle.f_12_500.colorABABAB,
          ).paddingSymmetric(horizontal: 24.w),
        ],
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.assets43.tr,
                style: AppTextStyle.f_14_500.color999999,
              ),
              Text(
                '${controller.address}',
                style: AppTextStyle.f_14_500,
                textAlign: TextAlign.end,
              )
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.assets44.tr,
                style: AppTextStyle.f_14_500.color999999,
              ),
              Expanded(
                  child: Text(
                '${controller.networkValue}',
                style: AppTextStyle.f_14_500.color4D4D4D,
                textAlign: TextAlign.end,
              ))
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.assets91.tr,
                style: AppTextStyle.f_14_500.color999999,
              ),
              Expanded(
                  child: Text(
                '${Decimal.parse(controller.amount)}',
                style: AppTextStyle.f_14_500.color4D4D4D,
                textAlign: TextAlign.end,
              )),
              Text(
                ' ${controller.currency}',
                style: AppTextStyle.f_14_500.color4D4D4D,
              )
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.assets92.tr,
                style: AppTextStyle.f_14_500.color999999,
              ),
              Expanded(
                  child: Text(
                '${Decimal.parse(controller.defaultFee)}',
                style: AppTextStyle.f_14_500.color4D4D4D,
                textAlign: TextAlign.end,
              )),
              Text(
                ' ${controller.currency}',
                style: AppTextStyle.f_14_500.color4D4D4D,
              )
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.assets93.tr,
                style: AppTextStyle.f_14_500.color999999,
              ),
              Expanded(
                  child: Text(
                LocaleKeys.assets94.tr,
                style: AppTextStyle.f_14_500.color4D4D4D,
                textAlign: TextAlign.end,
              ))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTip(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14.w),
      padding: EdgeInsets.fromLTRB(10.w, 16.h, 16.w, 16.h),
      decoration: BoxDecoration(
          color: AppColor.colorF5F5F5,
          borderRadius: BorderRadius.circular(6.r)),
      child: Row(
        children: [
          MyImage(
            'default/alert'.svgAssets(),
          ),
          SizedBox(
            width: 6.w,
          ),
          Expanded(
              child: Text(
            LocaleKeys.assets95.tr,
            style: AppTextStyle.f_12_500.colorABABAB,
          ))
        ],
      ),
    );
  }
}
