import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/price_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/controllers/commodity_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/models/contract_type.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_dotted_text.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../models/contract/res/position_res.dart';
import '../../../../widgets/components/transaction/bottom_sheet/adjust_margin_bottom_sheet.dart';
import '../../../../widgets/components/transaction/bottom_sheet/close_position_bottom_sheet.dart';
import '../../../../widgets/components/transaction/bottom_sheet/commodity_close_position_bottom_sheet.dart';
import '../../../../widgets/components/transaction/bottom_sheet/commodity_profit_lost_bottom_sheet.dart';
import '../../../../widgets/components/transaction/bottom_sheet/profit_lose_bottom_sheet.dart';
import '../../../../widgets/components/transaction/share_position_view.dart';

class ContractPositionItem extends StatelessWidget {
  const ContractPositionItem({
    super.key,
    required this.positionInfo,
    required this.contractType,
    this.canClose = true,
    required this.amountIndex,
  });

  final PositionInfo positionInfo;
  final ContractType contractType;
  final int amountIndex;

  /// 是否可以平仓
  final bool canClose;

  @override
  Widget build(BuildContext context) {
    final isSell = positionInfo.orderSide == 'SELL';
    return Container(
      padding: EdgeInsets.only(top: 2.h, bottom: 16.h, left: 16.w, right: 16.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorBorderGutter,
            width: 0.6,
          ),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(isSell),
          7.verticalSpace,
          _buildContent(isSell),
          if (canClose) _buildFooter(),
        ],
      ),
    );
  }

  _buildHeader(bool isSell) {
    ContractInfo? contractInfo;
    if (contractType == ContractType.E) {
      contractInfo = ContractDataStoreController.to
          .getContractInfoByContractId(positionInfo.contractId);
    } else {
      contractInfo = CommodityDataStoreController.to
          .getContractInfoByContractId(positionInfo.contractId);
    }
    if (contractInfo == null) {
      return Container();
    }

    return Row(
      children: <Widget>[
        _buySellTag(isSell ? LocaleKeys.trade103.tr : LocaleKeys.trade104.tr,
            isSell ? AppColor.colorDanger : AppColor.colorSuccess),
        6.horizontalSpace,
        InkWell(
          onTap: canClose
              ? () {
                  if (contractType == ContractType.E) {
                    if (contractInfo != null) {
                      ContractController.to.changeContractInfo(contractInfo);
                    }
                  } else {
                    if (contractInfo != null) {
                      CommodityController.to.changeContractInfo(contractInfo);
                    }
                  }
                }
              : null,
          child: Text(
            '${contractInfo?.firstName}${contractInfo?.secondName}',
            style: TextStyle(
              color: AppColor.color111111,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        6.horizontalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppColor.colorF4F4F4,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            contractType == ContractType.B
                ? LocaleKeys.trade6.tr
                : LocaleKeys.trade7.tr,
            style: TextStyle(
              color: AppColor.color333333,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ),
        6.horizontalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: AppColor.colorF4F4F4,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Text(
            '${positionInfo.positionType == 1 ? LocaleKeys.trade77.tr : LocaleKeys.trade78.tr}${positionInfo.leverageLevel}x',
            style: TextStyle(
              color: AppColor.color333333,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
        ),
        const Spacer(),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 20.w,
          ),
          child: IconButton(
            onPressed: () {
              SharePositionView.show(
                  positionInfo: positionInfo, type: contractType);
            },
            icon: Icon(
              Icons.share_outlined,
              color: AppColor.color111111,
              size: 18.w,
            ),
          ),
        ),
      ],
    );
  }

  _buildContent(bool isSell) {
    ContractInfo? contractInfo;
    PriceInfo? price;
    if (contractType == ContractType.E) {
      contractInfo = ContractDataStoreController.to
          .getContractInfoByContractId(positionInfo.contractId);
      price = ContractDataStoreController.to.priceMap[contractInfo?.symbol];
    } else {
      contractInfo = CommodityDataStoreController.to
          .getContractInfoByContractId(positionInfo.contractId);
      price = CommodityDataStoreController.to.priceMap[contractInfo?.symbol];
    }

    // 未实现盈亏
    // 多仓（BUY）：未实现盈亏 = 持仓数量*面值*汇率 * （当前标记价格-开仓均价）
    // 空仓（SELL）：未实现盈亏 = 持仓数量*面值*汇率 *（开仓均价-当前标记价格）
    // 回报率 = 未实现盈亏 / 保证金 * 100 (*100 是因为有%)
    num tagPrice = positionInfo.indexPrice;
    if (price != null) {
      tagPrice = price.tagPrice;
    }
    if (contractInfo == null) return Container();

    String unrealizedProfit;
    if (positionInfo.orderSide == 'BUY') {
      unrealizedProfit = (positionInfo.canCloseVolume.toDecimal() *
              (contractInfo.multiplier).toDecimal() *
              (tagPrice.toDecimal() - positionInfo.openAvgPrice.toDecimal()))
          .toStringAsFixed(2);
    } else {
      unrealizedProfit = (positionInfo.canCloseVolume.toDecimal() *
              (contractInfo.multiplier).toDecimal() *
              (positionInfo.openAvgPrice.toDecimal() - tagPrice.toDecimal()))
          .toStringAsFixed(2);
    }
    String returnRate = positionInfo.holdAmount.toDouble() == 0
        ? '0.00'
        : ((unrealizedProfit.toNum() / positionInfo.holdAmount.toDouble()) *
                100)
            .toString()
            .toNum()
            .toPrecision(2);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 未实现盈亏
            _amountTitle(
              title:
                  '${LocaleKeys.trade105.tr} (${positionInfo.symbol.symbolLast()})', //未实现盈亏
              onTitleTap: () {
                //加一个弹窗
                UIUtil.showAlert(LocaleKeys.trade105.tr,
                    content: LocaleKeys.assets138.tr);
              },
              amount: unrealizedProfit,

              amountStyle: TextStyle(
                color: unrealizedProfit.toNum() < 0
                    ? AppColor.colorDanger
                    : AppColor.colorSuccess,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            20.horizontalSpace,
            // 回报率
            _amountTitle(
              title: LocaleKeys.trade106.tr,
              amount: '$returnRate%',
              crossAxisAlignment: CrossAxisAlignment.end,
              onTitleTap: () {
                UIUtil.showAlert(LocaleKeys.trade106.tr,
                    content: LocaleKeys.trade285.tr);
              },
              amountStyle: TextStyle(
                color: returnRate.toNum() < 0
                    ? AppColor.colorDanger
                    : AppColor.colorSuccess,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        16.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              // 持仓数量
              child: _amountTitle(
                title:
                    '${LocaleKeys.trade107.tr} (${amountIndex == 0 ? positionInfo.symbol.symbolFirst() : positionInfo.symbol.symbolLast()})', //持仓数量
                onTitleTap: () {
                  //加一个弹窗
                  UIUtil.showAlert(LocaleKeys.trade107.tr,
                      content: LocaleKeys.assets140.tr); //这里还缺一个文案
                },
                amount: () {
                  String amount = '--';
                  Decimal multiplier =
                      contractInfo?.multiplier.toDecimal() ?? 1.toDecimal();
                  if (amountIndex == 0) {
                    amount = (positionInfo.positionVolume.toDecimal() *
                            multiplier)
                        .toPrecision(
                            contractInfo?.multiplier.numDecimalPlaces() ?? 4);
                  } else {
                    amount = (positionInfo.positionVolume.toDecimal() *
                            multiplier *
                            tagPrice.toDecimal())
                        .toPrecision(2);
                  }
                  return amount;
                }(),
              ),
            ),
            7.horizontalSpace,
            Expanded(
              // 保证金
              child: _amountTitle(
                  title:
                      '${LocaleKeys.trade21.tr} (${positionInfo.symbol.symbolLast()})', //保证金
                  onTitleTap: () {
                    //加一个弹窗
                    UIUtil.showAlert(LocaleKeys.trade21.tr,
                        content: LocaleKeys.assets139.tr);
                  },
                  amount: positionInfo.holdAmount.toPrecision(2),
                  hasLine: false,
                  // 可平的 并且是全仓模式 非交易员 才可调整保证金
                  onAdjustMargin: canClose &&
                          positionInfo.positionType != 1 &&
                          !UserGetx.to.isKol
                      ? () {
                          if (contractInfo != null) {
                            AdjustMarginBottomSheet.show(
                              positionInfo: positionInfo,
                              contractInfo: contractInfo,
                              contractType: contractType,
                            );
                          }
                        }
                      : null),
            ),
            7.horizontalSpace,
            Expanded(
              // 保证金率
              child: Builder(builder: (context) {
                String amount =
                    '${(positionInfo.marginRate * 100).toPrecision(2)}%';
                if (positionInfo.marginRate * 100 < 0.01 &&
                    positionInfo.marginRate * 100 > 0) {
                  amount = '0.01%';
                }

                /// 保证金率 小于 40% 正常 40% - 79.99% 异常 大于 80% 危险
                Color color = AppColor.colorSuccess;
                if (positionInfo.marginRate * 100 < 40) {
                  color = AppColor.colorSuccess;
                } else if (positionInfo.marginRate * 100 < 79.99) {
                  color = AppColor.colorAbnormal;
                } else {
                  color = AppColor.colorDanger;
                }
                return _amountTitle(
                  title: LocaleKeys.trade108.tr,
                  amount: amount,
                  onTitleTap: () {
                    //加一个弹窗
                    UIUtil.showAlert(LocaleKeys.trade108.tr,
                        content: LocaleKeys.trade284.tr);
                  },
                  amountStyle: TextStyle(
                    color: color,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  crossAxisAlignment: CrossAxisAlignment.end,
                );
              }),
            ),
          ],
        ),
        16.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              // 开仓均价
              child: _amountTitle(
                title:
                    '${LocaleKeys.assets30.tr} (${positionInfo.symbol.symbolLast()})',
                amount: positionInfo.openAvgPrice.toPrecision(
                    contractInfo.coinResultVo?.symbolPricePrecision.toInt() ??
                        2),
                hasLine: false,
              ),
            ),
            7.horizontalSpace,
            Expanded(
              // 标记价格
              child: _amountTitle(
                  title:
                      '${LocaleKeys.follow179.tr} (${positionInfo.symbol.symbolLast()})',
                  amount: positionInfo.indexPrice.toPrecision(
                      contractInfo.coinResultVo?.symbolPricePrecision.toInt() ??
                          2),
                  hasLine: false),
            ),
            7.horizontalSpace,
            Expanded(
              // 强平价格
              child: _amountTitle(
                title:
                    '${LocaleKeys.trade111.tr} (${positionInfo.symbol.symbolLast()})',
                amount: positionInfo.reducePrice > 0
                    ? positionInfo.reducePrice.toPrecision(contractInfo
                            .coinResultVo?.symbolPricePrecision
                            .toInt() ??
                        2)
                    : '--',
                crossAxisAlignment: CrossAxisAlignment.end,
                hasLine: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildFooter() {
    ContractInfo? contractInfo;
    if (contractType == ContractType.E) {
      contractInfo = ContractDataStoreController.to
          .getContractInfoByContractId(positionInfo.contractId);
    } else {
      contractInfo ??= CommodityDataStoreController.to
          .getContractInfoByContractId(positionInfo.contractId);
    }

    return Row(
      children: [
        Expanded(
          child: _buildButton(
              title: LocaleKeys.trade30.tr,
              onTap: () {
                if (contractInfo == null) {
                  return;
                }
                if (contractType == ContractType.E) {
                  ProfitLoseBottomSheet.show(
                      positionInfo: positionInfo,
                      contractInfo: contractInfo,
                      contractType: contractType);
                } else {
                  CommodityProfitLoseBottomSheet.show(
                    positionInfo: positionInfo,
                    contractInfo: contractInfo,
                  );
                }
              }),
        ),
        7.horizontalSpace,
        Expanded(
          child: _buildButton(
            title: LocaleKeys.trade19.tr,
            onTap: () {
              if (contractInfo == null) {
                return;
              }
              if (contractType == ContractType.E) {
                ClosePositionBottomSheet.show(
                    positionInfo: positionInfo, contractInfo: contractInfo);
              } else {
                CommodityClosePositionBottomSheet.show(
                    positionInfo: positionInfo, contractInfo: contractInfo);
              }
            },
          ),
        ),
      ],
    ).marginOnly(top: 16.h);
  }

  Widget _buildButton({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 32.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: AppColor.colorBorderStrong,
            width: 1,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.color111111,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _amountTitle({
    required String title,
    required String amount,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    TextStyle? titleStyle,
    TextStyle? amountStyle,
    VoidCallback? onAdjustMargin,
    VoidCallback? onTitleTap, // Add this line
    bool hasLine = true,
  }) {
    return InkWell(
      onTap: onTitleTap,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyDottedText(
                title,
                style: titleStyle ?? AppTextStyle.f_11_400.color999999,
                onTap: onTitleTap,
              ),
              if (onAdjustMargin != null)
                InkWell(
                  onTap: onAdjustMargin,
                  child: MyImage(
                    'assets/images/contract/adjust_margin.svg',
                    width: 12.w,
                  ),
                ).marginOnly(left: 2.w, right: 20.w),
            ],
          ),
          2.verticalSpace,
          Text(
            amount,
            style: amountStyle ??
                TextStyle(
                  color: AppColor.color4c4c4c,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  _buySellTag(String title, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11.sp,
          color: color,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
