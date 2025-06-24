import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_contract/widget/asset_contract_item.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commodity_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_controller.dart';
import 'package:nt_app_flutter/app/utils/utilities/contract_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/platform_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_balance.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_tabs.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../enums/public.dart';
import '../../../../utils/utilities/ui_util.dart';
import '../../../../widgets/components/assets/assets_action.dart';
import '../../../../widgets/components/assets/assets_profit.dart';
import '../../../../widgets/no/no_data.dart';
import '../../../assets/assets_contract/controllers/assets_contract_controller.dart';
import '../../../transation/commodity/models/contract_type.dart';
import '../../../transation/contract_postion/widgets/contract_postion_item.dart';

class AssetsContractView extends GetView<AssetsContractController> {
  const AssetsContractView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsContractController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<AssetsContractController>(builder: (controller) {
          return GetBuilder<AssetsGetx>(builder: (assetsGetx) {
            return SmartRefresher(
              controller: controller.refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () async {
                await Future.wait([assetsGetx.getRefresh()]);
                controller.refreshController.refreshToIdle();
                controller.refreshController.loadComplete();
              },
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: SliverToBoxAdapter(
                      child: _buildHeader(assetsGetx, controller),
                    ),
                  ),

                  /// 持有仓位
                  controller.index == 0
                      ? SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 0.w),
                          sliver: controller.getPositionList().isNotEmpty
                              ? SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (controller.contractIndex == 0) {
                                            CommodityController.to.tabController
                                                .animateTo(0);
                                          } else {
                                            ContractController.to.tabController
                                                .animateTo(1);
                                          }
                                          goToTrade(controller.contractIndex);
                                        },
                                        child: ContractPositionItem(
                                          positionInfo: controller
                                              .getPositionList()[index],
                                          contractType:
                                              controller.contractIndex == 0
                                                  ? ContractType.B
                                                  : ContractType.E,
                                          canClose: false,
                                          amountIndex: 0,
                                        ),
                                      );
                                    },
                                    childCount:
                                        controller.getPositionList().length,
                                  ),
                                )
                              : SliverToBoxAdapter(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 50.h),
                                    child: noDataWidget(context,
                                        wigetHeight: 200.h),
                                  ),
                                ),
                        )
                      : SliverPadding(
                          // 资产
                          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.w),
                          sliver: controller
                                  .getAssetList(controller.contractIndex)
                                  .isNotEmpty
                              ? SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return AssetContractItem(
                                        accountRes: controller.getAssetList(
                                            controller.contractIndex)[index],
                                      );
                                    },
                                    childCount: controller
                                        .getAssetList(controller.contractIndex)
                                        .length,
                                  ),
                                )
                              : SliverToBoxAdapter(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 100.h),
                                    child: noDataWidget(context,
                                        wigetHeight: 600.h),
                                  ),
                                ),
                        ),
                ],
              ),
            );
          });
        }));
  }

  Widget _buildHeader(
      AssetsGetx assetsGetx, AssetsContractController controller) {
    Get.log(
        'controller.contractIndex: ${controller.contractIndex} ${assetsGetx.assetContract.marginAmountUsd.toString()}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.verticalSpaceFromWidth,
        _buildTab(controller),
        16.verticalSpaceFromWidth,
        AssetsBalance(
          newStyle: true,
          title: LocaleKeys.assets5.tr,
          titleStyle: AppTextStyle.f_12_400.color4D4D4D,
          balance: controller.contractIndex == 1
              ? assetsGetx.assetContract.marginAmountUsd.toString()
              : assetsGetx.assetStandardContract.marginAmountUsd.toString(),
          tabType: controller.contractIndex == 1
              ? AssetsTabEnumn.contract
              : AssetsTabEnumn.standardContract,
        ),
        AssetsProfit(
            valueNum: assetsGetx.contrqactPnlAmount(controller.contractIndex),
            title: LocaleKeys.assets12.tr,
            titleStyle: AppTextStyle.f_11_400.color999999,
            value: NumberUtil.mConvert(
                assetsGetx.contrqactPnlAmount(controller.contractIndex),
                isEyeHide: true,
                isRate: IsRateEnum.usdt,
                count: 2),
            isTitleDotted: true,
            percent: assetsGetx.contrqactPnlRate(controller.contractIndex),
            onTap: () {
              UIUtil.showAlert(LocaleKeys.assets12.tr,
                  content: LocaleKeys.assets13.tr);
            }),
        16.verticalSpaceFromWidth,
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.colorF5F5F5),
                      borderRadius: BorderRadius.all(Radius.circular(8.r))),
                  margin: EdgeInsets.only(right: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${LocaleKeys.assets14.tr} ${'('}${controller.contractIndex == 1 ? assetsGetx.assetContract.totalBalanceSymbol : assetsGetx.assetStandardContract.totalBalanceSymbol}${')'}',
                          style: AppTextStyle.f_12_500.colorABABAB),
                      SizedBox(height: 4.h),
                      Text(
                          controller.contractIndex == 1
                              ? NumberUtil.mConvert(
                                  assetsGetx.assetContract.accountBalanceUsd,
                                  isEyeHide: true,
                                  count: 2,
                                  isRate: null)
                              : NumberUtil.mConvert(
                                  assetsGetx
                                      .assetStandardContract.accountBalanceUsd,
                                  isEyeHide: true,
                                  count: 2,
                                  isRate: null),
                          style: AppTextStyle.f_14_500.color111111),
                      SizedBox(height: 4.h),
                      Text(
                          "≈${NumberUtil.mConvert(controller.contractIndex == 1 ? assetsGetx.assetContract.accountBalanceUsd : assetsGetx.assetStandardContract.accountBalanceUsd, isEyeHide: true, isRate: IsRateEnum.usdt, count: controller.getcoinPrecision())}",
                          style: AppTextStyle.f_12_500.color999999),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.colorF5F5F5),
                      borderRadius: BorderRadius.all(Radius.circular(8.r))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${LocaleKeys.assets19.tr} ${'('}${controller.contractIndex == 1 ? assetsGetx.assetContract.totalBalanceSymbol : assetsGetx.assetStandardContract.totalBalanceSymbol}${')'}',
                          style: AppTextStyle.f_12_500.colorABABAB),
                      SizedBox(height: 4.h),
                      Text(
                          NumberUtil.mConvert(
                              controller.contractIndex == 1
                                  ? assetsGetx.assetContract.unRealizedAmountUsd
                                  : assetsGetx.assetStandardContract
                                      .unRealizedAmountUsd,
                              isEyeHide: true,
                              isRate: null,
                              count: 6),
                          style: AppTextStyle.f_14_500.color111111),
                      SizedBox(height: 4.h),
                      Text(
                          "≈${NumberUtil.mConvert(controller.contractIndex == 1 ? assetsGetx.assetContract.unRealizedAmountUsd : assetsGetx.assetStandardContract.unRealizedAmountUsd, isEyeHide: true, isRate: IsRateEnum.usdt, count: controller.getcoinPrecision())}",
                          style: AppTextStyle.f_12_500.color999999),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        AssetsAction(
            list: controller.actions,
            height: 36.w,
            newStyle: true,
            borderRadius: BorderRadius.all(Radius.circular(60.r)),
            onTap: controller.actionHandler),
        16.verticalSpaceFromWidth,
        AssetsTabs(
          fontSize: 14.sp,
          list: controller.tabs,
          controller: controller.tabController,
          left: 0,
        ),
      ],
    );
  }

  Widget _buildTab(AssetsContractController controller) {
    return Row(
      children: [
        /// 暂时添加
        if (!MyPlatFormUtil.isIOS())
          _buildBtn(LocaleKeys.assets16.tr, controller.contractIndex == 0, () {
            controller.changeContractIndex(0);
          }).marginOnly(right: 10.w),
        _buildBtn(LocaleKeys.assets17.tr, controller.contractIndex == 1, () {
          controller.changeContractIndex(1);
        }),
      ],
    );
  }

  Widget _buildBtn(String title, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
        // height: 22.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: isSelected ? AppColor.colorF1F1F1 : AppColor.transparent,
        ),
        child: Text(
          title,
          style: isSelected
              ? AppTextStyle.f_12_500.color111111
              : AppTextStyle.f_12_500.color999999,
        ),
      ),
    );
  }

  // buildContractAssetItem(AccountRes accountRes
  //     // String img,
  //     // String name,
  //     // AssetsContract assetContract,
  //     // AssetsContract assetStandardContract,
  //     // String futuresTotalBalance,
  //     // String standardFuturesBalance,
  //     // num canUseAmount
  //     ) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           MarketIcon(iconName: accountRes.symbol, width: 24.w),
  //           SizedBox(
  //             width: 8.w,
  //           ),
  //           Text(
  //             accountRes.symbol,
  //             style: AppTextStyle.body_500.color111111,
  //           )
  //         ],
  //       ),
  //       SizedBox(
  //         height: 16.h,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           SizedBox(
  //               width: 164.w,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(LocaleKeys.assets14.tr, style: AppTextStyle.small2_400.colorABABAB),
  //                   SizedBox(height: 2.h),
  //                   Text(NumberUtil.mConvert(accountRes.accountBalance, isEyeHide: true, count: 2),
  //                       style: AppTextStyle.medium_500.color111111),
  //                 ],
  //               )),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(LocaleKeys.assets15.tr, style: AppTextStyle.small2_400.colorABABAB),
  //               SizedBox(height: 2.h),
  //               Text(NumberUtil.mConvert(accountRes.unRealizedAmount, isEyeHide: true, isRate: null, count: 6),
  //                   style: AppTextStyle.medium_500.color111111),
  //             ],
  //           )
  //         ],
  //       ),
  //       SizedBox(height: 10.h),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           SizedBox(
  //             width: 164.w,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(LocaleKeys.assets20.tr, style: AppTextStyle.small2_400.colorABABAB),
  //                 SizedBox(height: 2.h),
  //                 Text(
  //                     NumberUtil.mConvert(
  //                         accountRes
  //                             // .totalMargin, // totalMargin ->  totalAmount 字段与web对齐
  //                             .marginAmount, // totalMargin ->  totalAmount 字段与web对齐 -> accountBalance
  //                         isEyeHide: true,
  //                         count: 2),
  //                     style: AppTextStyle.medium_500.color111111),
  //               ],
  //             ),
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(LocaleKeys.assets21.tr, style: AppTextStyle.small2_400.colorABABAB),
  //               SizedBox(height: 2.h),
  //               Text(NumberUtil.mConvert(accountRes.canTransferAmount, isEyeHide: true, count: 2),
  //                   style: AppTextStyle.medium_500.color111111),
  //             ],
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }
}
