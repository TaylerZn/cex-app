import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commodity_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity_position/controllers/commodity_position_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/commodiy_entrust/controllers/commondiy_entrust_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/widgets/count_down_widget.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_entrust/controllers/contract_entrust_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_postion/controllers/contract_position_controller.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_dotted_text.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../config/theme/app_color.dart';
import '../../../models/contract/res/funding_rate.dart';
import '../../../models/contract/res/user_config_info.dart';
import '../../../widgets/components/transaction/bottom_sheet/funding_rat_bottom_sheet.dart';
import '../../../widgets/components/transaction/bottom_sheet/leverage_multiple_bottom_sheet.dart';
import '../../../widgets/components/transaction/bottom_sheet/margin_type_bottom_sheet.dart';
import '../../../widgets/components/transaction/selection_button.dart';

class MarginLeverRate extends StatelessWidget {
  const MarginLeverRate({
    super.key,
    required this.onMarginModelChanged,
    required this.onLeverChanged,
    required this.fundingRate,
    required this.userConfig,
    required this.contractInfo,
    required this.onCountDownEnd,
    required this.margin,
    required this.guideType,
  });

  final Rxn<ContractInfo> contractInfo;
  final RxNum margin;
  final ValueChanged<int> onMarginModelChanged;
  final Rxn<UserConfigInfo> userConfig;
  final ValueChanged<int> onLeverChanged;
  final Rxn<FundingRate> fundingRate;
  final VoidCallback onCountDownEnd;
  final AppGuideType guideType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppGuideView(
          order: 2,
          guideType: guideType,
          finishCallback: () {
            if (guideType == AppGuideType.standardContract) {
              CommodityController.to.isGuiding.value = false;
            }
          },
          currentSetpCallback: () {
            if (guideType == AppGuideType.perpetualContract) {
              ContractController.to.scrollController.jumpTo(60.h);
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() {
                return SelectionButton.outline(
                  height: 22.h,
                  width: 80.w,
                  text: userConfig.value?.marginModel == 2
                      ? LocaleKeys.trade78.tr
                      : LocaleKeys.trade77.tr,
                  onTap: () async {
                    if (UserGetx.to.goIsLogin()) {
                      if (UserGetx.to.isKol) {
                        UIUtil.showToast(LocaleKeys.trade200.tr);
                        return;
                      }

                      /// 交易员不能更改杠杆
                      if (contractInfo.value!.contractType.contains('B')) {
                        if (UserGetx.to.isKol &&
                            CommodityPositionController.to
                                .checkHasPosition()) {
                          UIUtil.showToast(LocaleKeys.trade201.tr);
                          return;
                        }

                        /// 有本合约持仓时不可更改杠杆
                        if (CommodityEntrustController.to
                            .checkCurrentContractHasOrder(
                            contractInfo.value!)) {
                          UIUtil.showToast(LocaleKeys.trade202.tr);
                          return;
                        }
                      } else {
                        /// 交易员不能更改杠杆
                        if (UserGetx.to.isKol &&
                            ContractPositionController.to
                                .checkHasPosition()) {
                          UIUtil.showToast(LocaleKeys.trade201.tr);
                          return;
                        }

                        /// 有本合约持仓时不可更改杠杆
                        if (ContractEntrustController.to
                            .checkCurrentContractHasOrder(
                            contractInfo.value!)) {
                          UIUtil.showToast(LocaleKeys.trade203.tr);
                          return;
                        }
                      }

                      int? res = await MarginTypeBottomSheet.show(
                          marginModel: userConfig.value?.marginModel ?? 1);
                      if (res != null) {
                        onMarginModelChanged(res);
                      }
                    }
                  },
                );
              }),
              8.horizontalSpace,
              Obx(() {
                return SelectionButton.outline(
                    height: 24.h,
                    width: 70.w,
                    text: '${userConfig.value?.getNowLevel() ?? 20}x',
                    onTap: () async {
                      if (contractInfo.value == null) return;
                      if (UserGetx.to.goIsLogin()) {
                        /// 交易员不能更改杠杆
                        if (contractInfo.value!.contractType.contains('B')) {
                          if (UserGetx.to.isKol &&
                              CommodityPositionController.to
                                  .checkHasPosition()) {
                            UIUtil.showToast(LocaleKeys.trade201.tr);
                            return;
                          }

                          /// 有本合约持仓时不可更改杠杆
                          if (CommodityEntrustController.to
                              .checkCurrentContractHasOrder(
                                  contractInfo.value!)) {
                            UIUtil.showToast(LocaleKeys.trade202.tr);
                            return;
                          }
                        } else {
                          /// 交易员不能更改杠杆
                          if (UserGetx.to.isKol &&
                              ContractPositionController.to
                                  .checkHasPosition()) {
                            UIUtil.showToast(LocaleKeys.trade201.tr);
                            return;
                          }

                          /// 有本合约持仓时不可更改杠杆
                          if (ContractEntrustController.to
                              .checkCurrentContractHasOrder(
                                  contractInfo.value!)) {
                            UIUtil.showToast(LocaleKeys.trade203.tr);
                            return;
                          }
                        }

                        final res = await LeverageMultipleBottomSheet.show(
                            userConfig.value?.getNowLevel() ?? 20,
                            userConfig.value?.minLevel ?? 1,
                            userConfig.value?.maxLevel ?? 100,
                            userConfig.value?.userMaxLevel ?? 100,
                            margin.value);
                        if (res != null) {
                          onLeverChanged(res);
                        }
                      }
                    });
              }),
            ],
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            FundingRatBottomSheet.show(
                fundingRate: fundingRate.value!,
                period: contractInfo.value?.capitalFrequency.toInt() ?? 8);
          },
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                MyDottedText(
                  onTap: () {
                    FundingRatBottomSheet.show(
                        fundingRate: fundingRate.value!,
                        period: contractInfo.value?.capitalFrequency.toInt() ??
                            8);
                  },
                  '${LocaleKeys.trade88.tr} / ${LocaleKeys.trade204.tr}',
                  style: AppTextStyle.f_10_400.color666666,
                ),
                Row(
                  children: [
                    Text(
                      fundingRate.value?.nextFundRate == null
                          ? '-- / '
                          : '${(fundingRate.value!.nextFundRate! * 100).toStringAsFixed(5)}% / ',
                      textAlign: TextAlign.right,
                      style: AppTextStyle.f_11_500.copyWith(
                        color: AppColor.color333333,
                      ),
                    ),
                    Obx(() {
                      return CountDownWidget(
                        key: ValueKey(
                            (userConfig.value?.nextCapitalTime.toString() ??
                                    '') +
                                (contractInfo.value?.id ?? 1).toString()),
                        nextCapitalTime: userConfig.value?.nextCapitalTime ?? 0,
                        onCountDownEnd: onCountDownEnd,
                      );
                    }),
                  ],
                ),
              ],
            );
          }),
        )
      ],
    );
  }
}
