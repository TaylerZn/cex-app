import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_transfer/enums/account_enums.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_transfer/widgets/assets_transfer_account.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/assets_transfer_controller.dart';

class AssetsTransferView extends GetView<AssetsTransferController> {
  const AssetsTransferView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => MySystemStateBar(
            child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColor.colorWhite,
          appBar: AppBar(
            leading: const MyPageBackWidget(),
            backgroundColor: AppColor.colorWhite,
            actions: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.WALLET_HISTORY,
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: MyImage(
                    'default/history'.svgAssets(),
                    width: 18.r,
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 16.h, right: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(LocaleKeys.assets7.tr,
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: AppColor.color111111,
                          fontWeight: FontWeight.w600,
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 12.h),
                      padding: EdgeInsets.fromLTRB(16, 20.h, 24.w, 20.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColor.colorF5F5F5),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 30.w),
                                child: Text(LocaleKeys.assets77.tr, //from
                                    style: AppTextStyle.f_15_600.color999999),
                              ),
                              Expanded(
                                child: GestureDetector(
                                    onTap: () async {
                                      int? res = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AssetsTransferAccount(
                                                  type:
                                                      AssetsTransferAccountEnum
                                                          .from,
                                                  array: controller.list,
                                                  current:
                                                      controller.from.value,
                                                  other: controller.to.value,
                                                )),
                                      );
                                      if (res != null) {
                                        controller.from.value = res;
                                        controller.updateTransferAccount(
                                            AssetsTransferAccountEnum.from);
                                        controller.updateTransferBalance();
                                      }
                                    },
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              controller
                                                  .list[controller.from.value]
                                                  .name,
                                              style: AppTextStyle
                                                  .f_15_600.color111111),
                                          MyImage(
                                            'assets/assets_right'.svgAssets(),
                                            width: 16.r,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox(width: 44.w),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Row(
                              children: <Widget>[
                                MyImage(
                                    'assets/images/trade/assetsTransferleft.png',
                                    height: 24.w),
                                const Expanded(child: SizedBox()),
                                InkWell(
                                    onTap: () {
                                      controller.exchange();
                                      controller.textController?.clear();
                                    },
                                    child: MyImage(
                                            'assets/images/trade/assetsTransferRight.png',
                                            height: 20.w)
                                        .paddingOnly(left: 20.w, right: 4.w)),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Get.locale?.languageCode == 'en'
                                      ? 50.w
                                      : 30.w,
                                ),
                                child: Text(LocaleKeys.assets78.tr, //to
                                    style: AppTextStyle.f_15_600.color999999),
                              ),
                              Expanded(
                                child: GestureDetector(
                                    onTap: () async {
                                      int? res = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AssetsTransferAccount(
                                                    type:
                                                        AssetsTransferAccountEnum
                                                            .to,
                                                    array: controller.list,
                                                    current:
                                                        controller.to.value,
                                                    other:
                                                        controller.from.value)),
                                      );
                                      if (res != null) {
                                        controller.to.value = res;
                                        controller.updateTransferAccount(
                                            AssetsTransferAccountEnum.to);
                                      }
                                    },
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                                controller.toCurrency.name,
                                                // .list[controller.to.value]
                                                // .name,
                                                style: AppTextStyle
                                                    .f_15_600.color111111),
                                          ),
                                          MyImage(
                                            'assets/assets_right'.svgAssets(),
                                            width: 16.r,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              SizedBox(width: 44.w),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // controller.currencySelect(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20.h, bottom: 0.h),
                        padding: EdgeInsets.fromLTRB(18, 13.h, 16, 11.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.colorF5F5F5),
                        child: Row(
                          children: <Widget>[
                            MyImage(
                              'currency/USDT'.svgAssets(),
                              width: 23.w,
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(controller.currency.value,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColor.color111111,
                                  fontWeight: FontWeight.w700,
                                )),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24.h, bottom: 0.h),
                      child: Text(
                        LocaleKeys.assets79.tr,
                        style: AppTextStyle.f_12_500.color666666,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8.h, bottom: 10.h),
                      height: 44.h,
                      padding: const EdgeInsets.fromLTRB(18, 0, 10, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColor.colorF5F5F5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: TextField(
                            controller: controller.textController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                )),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d*'))
                            ],
                          )),
                          Text(
                            controller.currency.value,
                            style: AppTextStyle.f_16_500.colorABABAB,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          InkWell(
                            onTap: () {
                              controller.textController!.text =
                                  controller.currencyBalance.value;
                            },
                            child: Text(
                              LocaleKeys.assets80.tr,
                              style: AppTextStyle.f_14_600.color0075FF,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${LocaleKeys.assets81.tr}:',
                            style: AppTextStyle.f_12_500.color666666,
                          ),
                          TextSpan(
                            text:
                                '${controller.currencyBalance} ${controller.currency}',
                            style: AppTextStyle.f_12_500.color666666,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    )
                  ],
                ),
              ),
              Spacer(),
              buildBottomBtn()
            ]),
          ),
        )));
  }

  buildBottomBtn() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.colorWhite,
        border: Border(
          top: BorderSide(color: AppColor.colorBorderStrong, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyButton(
          text: LocaleKeys.assets82.tr,
          width: double.infinity,
          height: 48.h,
          borderRadius: BorderRadius.circular(100.r),
          color: AppColor.colorWhite,
          backgroundColor: controller.isDisabled()
              ? AppColor.colorCCCCCC
              : AppColor.color111111,
          onTap: () {
            controller.transfer();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(LocaleKeys.assets82.tr,
                  style: AppTextStyle.f_16_600.colorWhite),
              MyImage(
                'flow/follow_setup_arrow'.svgAssets(),
                height: 24.r,
                width: 24.r,
                color: AppColor.colorWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
