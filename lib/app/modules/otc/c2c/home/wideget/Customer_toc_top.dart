// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/controllers/customer_toc_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_model.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_order.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_sheet.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CustomerTocTopView extends StatelessWidget {
  const CustomerTocTopView({super.key, required this.controller});
  final CustomerTocController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorWhite,
      padding: EdgeInsets.fromLTRB(16.w, 0, 0, 0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // showCustomerTocSheetView(controller.requestModel.fiterCoin);
            },
            child: Row(
              children: <Widget>[
                MarketIcon(
                  iconName: 'USDT'.tr,
                  width: 18,
                ),
                Text(
                  'USDT',
                  style: AppTextStyle.f_14_500.color111111,
                ).marginOnly(left: 4.w),
                // MyImage(
                //   'otc/c2c/c2c_more'.svgAssets(),
                //   width: 10.w,
                //   height: 10.w,
                // ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          GestureDetector(
            onTap: () {
              if (controller.requestModel.value.complete) {
                showCustomerTocSheetView(controller.requestModel.value,
                    bottomType: CustomerSheetType.amountType);
              }
            },
            child: Row(
              children: <Widget>[
                Obx(() => Text(
                      controller.requestModel.value.filterAmount.topTitle.value,
                      style: AppTextStyle.f_14_500.color111111,
                    )),
                MyImage(
                  'otc/c2c/c2c_more'.svgAssets(),
                  fit: BoxFit.cover,
                  width: 14.w,
                  height: 7.h,
                ).paddingOnly(left: 2.w, top: 4.h)
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              if (controller.requestModel.value.complete &&
                  UserGetx.to.goIsLogin()) {
                showCustomerTocSheetView(controller.requestModel.value,
                    bottomType: CustomerSheetType.filterType);
              }
            },
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: MyImage(
                'otc/c2c/c2c_filter'.svgAssets(),
                width: 16.w,
                height: 16.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerAlterView {
  static showGuardView(Function? callback) {
    UIUtil.showAlert(
        isDismissible: true,
        LocaleKeys.c2c200.tr,
        content: LocaleKeys.c2c201.tr,
        confirmText: LocaleKeys.c2c202.tr, confirmHandler: () {
      Get.back();
      callback?.call();
    });
  }

  static Future showSurePay(Function? callback) async {
    return await UIUtil.showConfirm(
        isDismissible: true,
        LocaleKeys.c2c236.tr,
        content: LocaleKeys.c2c237.tr,
        cancelText: LocaleKeys.c2c238.tr,
        confirmText: LocaleKeys.public1.tr, confirmHandler: () {
      Get.back();
      callback?.call();
    });
  }

  static Future showSureCancelOrder(
      CustomerOrderDetailModel model, Function? callback) async {
    return await UIUtil.showConfirm(
        isDismissible: true,
        LocaleKeys.c2c244.tr,
        content: LocaleKeys.c2c245.tr,
        contentWidget: Padding(
          padding: EdgeInsets.only(top: 0.h),
          child: Row(
            children: <Widget>[
              InkWell(
                  onTap: () {
                    model.isSelected.value = !model.isSelected.value;
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 4),
                      child: Obx(() => MyImage(
                            'contract/${model.isSelected.value ? 'market_select' : 'market_unSelect'}'
                                .svgAssets(),
                          )))),
              Expanded(
                  child: Text(LocaleKeys.c2c246.tr,
                      style: AppTextStyle.f_12_400.color333333)),
            ],
          ),
        ),
        cancelText: LocaleKeys.public2.tr,
        confirmText: LocaleKeys.public1.tr, confirmHandler: () {
      if (model.isSelected.value) {
        Get.back();
        callback?.call();
      } else {
        UIUtil.showToast(LocaleKeys.user24.tr);
      }
    });
  }

  static Future showAppealCancel(Function? callback) async {
    return await UIUtil.showConfirm(
        isDismissible: true,
        LocaleKeys.c2c279.tr,
        content: LocaleKeys.c2c280.tr,
        cancelText: LocaleKeys.c2c146.tr,
        confirmText: LocaleKeys.public1.tr, confirmHandler: () {
      Get.back();
      callback?.call();
    });
  }

  static showAppeal(RxString textStr, Function? callback) {
    Get.dialog(CustomerDialog(text: textStr, callback: callback),
        transitionDuration: const Duration(milliseconds: 25));
  }

  static Future showProceedOrder(Function? callback) async {
    return await UIUtil.showConfirm(
        isDismissible: true,
        LocaleKeys.c2c214.tr,
        cancelText: LocaleKeys.public2.tr,
        confirmText: LocaleKeys.c2c215.tr, confirmHandler: () {
      Get.back();
      callback?.call();
    });
  }
}

class CustomerDialog extends StatelessWidget {
  const CustomerDialog({
    super.key,
    this.callback,
    required this.text,
  });
  final Function? callback;
  final RxString text;
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          width: 238.w,
          padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.c2c62.tr,
                style: AppTextStyle.f_16_500.color111111,
              ).marginOnly(bottom: 7.h),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: LocaleKeys.c2c115.tr,
                      style: AppTextStyle.f_12_400_15.color666666,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      text: LocaleKeys.c2c117.tr,
                      color: AppColor.colorWhite,
                      textStyle: AppTextStyle.f_15_600.color111111,
                      height: 44.h,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Obx(() => MyButton(
                            text: text.value.isNotEmpty
                                ? text.value
                                : LocaleKeys.c2c262.tr,
                            border: Border.all(
                                width: 1,
                                color: text.value.isNotEmpty
                                    ? Colors.transparent
                                    : AppColor.colorDCDCDC),
                            color: AppColor.color111111,
                            backgroundColor: AppColor.colorWhite,
                            textStyle: AppTextStyle.f_15_600.color111111,
                            height: 44.h,
                            onTap: () {
                              if (text.value.isEmpty) {
                                Get.back();
                                callback?.call();
                              }
                            },
                          ))),
                ],
              ).paddingOnly(top: 4.w),
            ],
          ),
        ));
  }
}
