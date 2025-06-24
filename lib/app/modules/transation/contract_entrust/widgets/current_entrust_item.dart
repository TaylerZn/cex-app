import 'package:common_utils/common_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/order_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_depth_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../models/contract/res/price_info.dart';

class CurrentEntrustItem extends StatelessWidget {
  const CurrentEntrustItem(
      {super.key,
      required this.orderInfo,
      required this.onTap,
      this.amountIndex = 0,
      required this.isCommodity});

  final OrderInfo orderInfo;
  final VoidCallback onTap;
  final int amountIndex;
  final bool isCommodity;

  @override
  Widget build(BuildContext context) {
    bool isSell = orderInfo.side == 'SELL';
    String title = '';
    ContractInfo? contractInfo;
    PriceInfo? priceInfo;
    if (isCommodity) {
      contractInfo = CommodityDataStoreController.to
          .getContractInfoByContractId(orderInfo.contractId);
      priceInfo = CommodityDataStoreController.to
          .getPriceInfoBySubSymbol(contractInfo?.contractName ?? '');
    } else {
      contractInfo = ContractDataStoreController.to
          .getContractInfoByContractId(orderInfo.contractId);
      priceInfo = ContractDataStoreController.to
          .getPriceInfoBySubSymbol(contractInfo?.contractName ?? '');
    }
    if (contractInfo != null) {
      title = contractInfo.getContractType;
    }
    if (contractInfo == null) {
      return SizedBox();
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.6,
            color: AppColor.colorBorderGutter,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                (contractInfo?.firstName ?? '-') +
                    (contractInfo?.secondName ?? '-'),
                style: AppTextStyle.f_14_600.copyWith(
                    color: AppColor.color111111,
                    textBaseline: TextBaseline.alphabetic),
              ),
              if (title.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  margin: EdgeInsets.only(left: 4.w),
                  decoration: ShapeDecoration(
                    color: AppColor.colorF3F3F3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  child: Text(
                    title,
                    style: AppTextStyle.f_10_500.copyWith(
                      color: AppColor.color4D4D4D,
                    ),
                  ),
                ),
              const Spacer(),
              InkWell(
                onTap: onTap,
                child: Container(
                  height: 24.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      width: 1,
                      color: AppColor.colorBorderStrong,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    LocaleKeys.trade102.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.color111111,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          2.verticalSpace,
          Row(
            children: [
              _buildTags(
                [
                  orderInfo.getOrderType(orderInfo.type),
                  orderInfo.getOpenSide(orderInfo.open, orderInfo.side)
                ],
                isSell ? AppColor.colorDanger : AppColor.colorSuccess,
              ),
              4.horizontalSpace,
              Text(
                DateUtil.formatDateMs(orderInfo.ctime.toInt()),
                style: AppTextStyle.f_11_500.copyWith(
                  color: AppColor.color999999,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${LocaleKeys.trade96.tr}(${amountIndex == 0 ? orderInfo.symbol.symbolFirst() : orderInfo.symbol.symbolLast()})',
                    style: AppTextStyle.f_11_400.copyWith(
                      color: AppColor.color999999,
                    ),
                  ),
                  Builder(builder: (context) {
                    // 市价需要 数量 = volume / 触发价
                    // 数量 = volume * 面值
                    String dealVolume = '';
                    String volume = '';
                    Decimal tiggerPrice = Decimal.one;
                    Decimal multiplier =
                        (contractInfo?.multiplier ?? 1).toDecimal();

                    /// 数量精度
                    int volumnPrecision =
                        contractInfo?.multiplier.numDecimalPlaces() ?? 4;

                    4;

                    /// 市价
                    /// 市价需要 数量 = volume / 触发价
                    if (orderInfo.type == 2 &&
                        orderInfo.triggerType != 0 &&
                        orderInfo.triggerPrice != null) {
                      tiggerPrice =
                          orderInfo.triggerPrice.toString().toDecimal();

                      /// 目标币种
                      if (amountIndex == 0) {
                        dealVolume =
                            (orderInfo.dealVolume.toDecimal() / tiggerPrice)
                                .toDecimal(scaleOnInfinitePrecision: 10)
                                .toPrecision(volumnPrecision);
                        volume = (orderInfo.volume.toDecimal() / tiggerPrice)
                            .toDecimal(scaleOnInfinitePrecision: 10)
                            .toPrecision(volumnPrecision);
                      } else {
                        /// USDT
                        dealVolume = orderInfo.dealVolume.toStringAsFixed(2);
                        volume = orderInfo.volume.toStringAsFixed(2);
                      }
                    } else {
                      /// 止盈止损
                      /// 数量 = volume * 面值
                      if (amountIndex == 0) {
                        dealVolume =
                            (orderInfo.dealVolume.toDecimal() * multiplier)
                                .toPrecision(volumnPrecision);
                        volume = (orderInfo.volume.toDecimal() * multiplier)
                            .toPrecision(volumnPrecision);
                      } else {
                        dealVolume = (orderInfo.dealVolume.toDecimal() *
                                multiplier *
                                orderInfo.price.toDecimal())
                            .toStringAsFixed(2);
                        volume = (orderInfo.volume.toDecimal() *
                                multiplier *
                                orderInfo.price.toDecimal())
                            .toStringAsFixed(2);
                      }
                    }
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          dealVolume,
                          style: AppTextStyle.f_13_500.copyWith(
                            color: AppColor.color4D4D4D,
                          ),
                        ),
                        Text('/$volume',
                            style: AppTextStyle.f_13_500.copyWith(
                              color: AppColor.colorABABAB,
                            )),
                      ],
                    );
                  }),
                ],
              ),
              if (orderInfo.triggerType != 0)
                _buildItem(
                  LocaleKeys.trade45.tr,
                  orderInfo.open.toUpperCase() == 'CLOSE'
                      ? LocaleKeys.trade98.tr
                      : LocaleKeys.trade99.tr,
                ).marginOnly(top: 4.h),
              4.verticalSpace,
              _buildItem(
                LocaleKeys.trade34.tr,
                orderInfo.price > 0
                    ? orderInfo.price.toStringAsFixed(
                        ContractDepthController.to.precision.numDecimalPlaces(),
                      )
                    : LocaleKeys.trade74.tr,
              ),
              if (orderInfo.triggerType != 0)
                _buildItem(LocaleKeys.trade100.tr,
                        '${LocaleKeys.trade110.tr}${orderInfo.gt ? '≥' : '≤'} ${orderInfo.triggerPrice}')
                    .marginOnly(top: 4.h),
              if (orderInfo.tpTriggerPrice != null ||
                  orderInfo.slTriggerPrice != null)
                Builder(builder: (context) {
                  String title;
                  String amount;
                  List<String> triggerTitles = [];
                  List<String> amountTitles = [];
                  if (orderInfo.tpTriggerPrice != null) {
                    triggerTitles.add(LocaleKeys.trade82.tr);
                    amountTitles.add(
                      orderInfo.tpTriggerPrice.toString(),
                    );
                  }
                  if (orderInfo.slTriggerPrice != null) {
                    triggerTitles.add(LocaleKeys.trade83.tr);
                    amountTitles.add(
                      orderInfo.slTriggerPrice.toString(),
                    );
                  }
                  title = triggerTitles.join('/');
                  amount = amountTitles.join('/');
                  return _buildItem(title, amount).marginOnly(top: 4.h);
                }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.f_11_400.colorTextTips,
        ),
        Text(
          value,
          style: AppTextStyle.f_13_500.colorTextTertiary,
        ),
      ],
    );
  }

  Widget _buildTags(List<String> tags, Color color) {
    return Row(
      children: tags
          .map(
            (e) => Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              height: 16.h,
              margin: EdgeInsets.only(right: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: color.withOpacity(0.1),
              ),
              alignment: Alignment.center,
              child:
                  Text(e, style: AppTextStyle.f_10_500.copyWith(color: color)),
            ),
          )
          .toList(),
    );
  }
}
