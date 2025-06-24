import 'package:auto_size_text/auto_size_text.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_withdrawal/dialog/assets_network_select.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_withdrawal/dialog/notice_dialog.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_withdrawal/widget/asset_input_widget.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/feedback/page_loading.dart';
import 'package:nt_app_flutter/app/widgets/feedback/scan.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../utils/utilities/text_input_formatter.dart';
import '../../../../widgets/dialog/my_bottom_dialog.dart';
import '../../../../widgets/dialog/tip_dialog.dart';
import '../controllers/assets_withdrawal_controller.dart';

class AssetsWithdrawalView extends GetView<AssetsWithdrawalController> {
  const AssetsWithdrawalView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssetsWithdrawalController>(builder: (assetsController) {
      return Obx(
        () => Scaffold(
          appBar: AppBar(
            leading: const MyPageBackWidget(),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MarketIcon(
                  iconName: controller.currency.value,
                  width: 20.w,
                ),
                8.horizontalSpace,
                Text(controller.currency.value),
                2.horizontalSpace,
                Text(LocaleKeys.assets64.tr)
              ],
            ),
            centerTitle: true,
          ),
          body: MyPageLoading(
              controller: controller.loadingController,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      24.verticalSpaceFromWidth,
                      _buildAddress(context),
                      24.verticalSpaceFromWidth,
                      _buildNetwork(context),
                      24.verticalSpaceFromWidth,
                      _buildAmount(context),
                      12.verticalSpaceFromWidth,
                      InkWell(
                        onTap: () async {
                          final bool res = await Get.toNamed(
                              Routes.ASSETS_TRANSFER,
                              arguments: {"from": 1, "to": 3});
                          if (res) {
                            await AssetsGetx.to.getRefresh();
                            controller.reloadBalance();
                          }
                        },
                        child: GetBuilder<AssetsGetx>(builder: (getx) {
                          return InkWell(
                              onTap: () async {
                                final bool res = await Get.toNamed(
                                    Routes.ASSETS_TRANSFER,
                                    arguments: {"from": 1, "to": 3});
                                if (res) {
                                  AssetsGetx.to.getSpotCanUseBalance();
                                }
                              },
                              child: Row(
                                children: [
                                  Text(LocaleKeys.assets176.tr,
                                      style:
                                          AppTextStyle.f_12_400.colorTextTips),
                                  AutoSizeText(
                                    '${AssetsGetx.to.getSpotCanUseBalance(coinName: controller.currency.value)} ${controller.currency.value}',
                                    style: AppTextStyle.f_12_400.colorTextTips,
                                    maxLines: 1,
                                  ),
                                  6.horizontalSpace,
                                  MyImage(
                                    'assets/transfer_icon'.svgAssets(),
                                    width: 12.w,
                                  )
                                ],
                              ));
                        }),
                      )
                    ],
                  ),
                ),
              )),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 1, color: AppColor.colorBorderGutter))),
            padding: EdgeInsets.fromLTRB(
                16.w, 12.h, 16.w, 16.h + MediaQuery.of(context).padding.bottom),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(LocaleKeys.assets177.tr,
                          style: AppTextStyle.f_11_400.color999999),
                      8.verticalSpaceFromWidth,
                      Text(
                          '${controller.allowSubmit ? controller.receiveAmount : '-'}${controller.currency.value}',
                          style: AppTextStyle.f_16_500.color111111),
                      8.verticalSpaceFromWidth,
                      Text(
                          '${LocaleKeys.assets178.tr}${controller.allowSubmit ? controller.defaultFee : '-'} ${controller.currency.value}',
                          style: AppTextStyle.f_11_400.color999999)
                    ],
                  ),
                ),
                SizedBox(
                  width: 164.w,
                  child: MyButton(
                    height: 36.w,
                    textStyle: AppTextStyle.f_14_600,
                    borderRadius: BorderRadius.circular(60),
                    text: LocaleKeys.assets53.tr,
                    color: controller.allowSubmit
                        ? AppColor.colorFFFFFF
                        : AppColor.colorTextDisabled,
                    backgroundColor: controller.allowSubmit
                        ? AppColor.colorBlack
                        : AppColor.colorBackgroundTertiary,
                    onTap: () {
                      if (controller.allowSubmit) {
                        controller.withdrawal(context);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNetwork(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              LocaleKeys.assets179.tr,
              style: AppTextStyle.f_13_500.color4D4D4D,
            ),
            4.horizontalSpace,
            InkWell(
              onTap: () {
                Get.dialog(TipsDialog(
                    title: LocaleKeys.assets179.tr,
                    content: LocaleKeys.assets180.tr,
                    okTitle: LocaleKeys.public57.tr,
                    isContentCenter: true));
              },
              child: MyImage('assets/notice'.svgAssets()),
            )
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                color: AppColor.colorBackgroundInput),
            height: 48.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.networkValue,
                  style: ObjectUtil.isEmpty(controller.networkList)
                      ? AppTextStyle.f_14_500.colorTextDisabled
                      : AppTextStyle.f_14_500.color111111,
                ),
                MyImage(
                  'default/arrow_bottom'.svgAssets(),
                  height: 20.h,
                  color: AppColor.color999999,
                )
              ],
            ),
          ),
          onTap: () async {
            var res = await showMyBottomDialog(
                context,
                WithdrawAssetsNetworkSelect(
                  list: controller.networkList,
                  value: controller.networkValue,
                  isDeposit: false,
                ));
            if (res != null) {
              controller.networkIndex = res;
              controller.update();
            }
          },
        )
      ],
    );
  }

  Widget _buildAddress(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${controller.currency.value} ${LocaleKeys.assets172.tr}',
                style: AppTextStyle.f_13_500.color4D4D4D,
              ),
              4.horizontalSpace,
              InkWell(
                onTap: () {
                  Get.dialog(TipsDialog(
                      title:
                          '${controller.currency.value} ${LocaleKeys.assets172.tr}',
                      content: LocaleKeys.assets173.tr,
                      okTitle: LocaleKeys.public57.tr,
                      isContentCenter: true));
                },
                child: MyImage('assets/notice'.svgAssets()),
              )
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          AssetInputWidget(
              hint: LocaleKeys.assets97.tr,
              maxLines: null,
              controller: controller.textController,
              child: InkWell(
                onTap: () {
                  Get.to(MyScanView())?.then((value) {
                    controller.textController.text = value;
                  });
                },
                child: MyImage(
                  'default/scan'.svgAssets(),
                  height: 20.w,
                  color: AppColor.color111111,
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildAmount(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(LocaleKeys.assets174.tr,
                style: AppTextStyle.f_13_500.color4D4D4D),
            4.horizontalSpace,
            InkWell(
              onTap: () {
                final String currency = controller.currency.value;
                Get.dialog(NoticeDialog(
                  withdrawMax: controller.withdrawMaxDayBalance,
                  withdrawMaxDay: controller.withdrawMaxDay,
                  currency: currency,
                ));
              },
              child: MyImage('assets/notice'.svgAssets()),
            )
          ],
        ),
        8.verticalSpaceFromWidth,
        AssetInputWidget(
          border: controller.inSufficient
              ? Border.all(color: AppColor.colorTextError)
              : null,
          controller: controller.amountController,
          inputFormatters: [
            MyNumberInputFormatter(),
            allow(controller.showPrecision.toInt()), // 添加这一行
          ],
          hint: "${LocaleKeys.assets162.tr} ${controller.min.value}",
          child: Row(
            children: [
              Obx(() {
                return Text(
                  controller.currency.value,
                  style: AppTextStyle.f_14_400.colorABABAB,
                );
              }),
              Container(
                width: 1,
                height: 12,
                color: AppColor.colorBackgroundDisabled,
              ).marginSymmetric(horizontal: 8.w),
              InkWell(
                onTap: () {
                  controller.setMax();
                },
                child: Text(
                  LocaleKeys.assets80.tr,
                  style: AppTextStyle.f_14_400.tradingYel,
                ),
              )
            ],
          ),
        ),
        Visibility(
            visible: controller.inSufficient,
            child: Container(
              margin: EdgeInsets.only(top: 8.w),
              child: Text(LocaleKeys.assets175.tr,
                  style: AppTextStyle.f_12_400.colorTextError),
            ))
      ],
    );
  }
}
