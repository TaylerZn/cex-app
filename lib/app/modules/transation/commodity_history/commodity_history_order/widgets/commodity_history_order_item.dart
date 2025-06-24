import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/order_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/app_text_style.dart';

class CommodityHistoryOrderItem extends StatelessWidget {
  const CommodityHistoryOrderItem({super.key, required this.model});

  final OrderInfo model;

  @override
  Widget build(BuildContext context) {
    ContractInfo? contractInfo = CommodityDataStoreController.to
        .getContractInfoByContractId(model.contractId ?? 0);

    final leftStyle = AppTextStyle.f_13_400.colorTextDescription;
    final rightStyle = AppTextStyle.f_13_500.colorTextPrimary;

    Color sideColor =
        model.side == 'SELL' ? AppColor.colorDanger : AppColor.colorSuccess;
    List<String> tagArray = [
      model.type == 1 ? LocaleKeys.trade73.tr : LocaleKeys.trade74.tr,
      model.getOpenSide(model.open, model.side)
    ];
    var dealVolumeStr = (model.dealVolume.toDecimal() *
            (contractInfo?.multiplier ?? 1).toDecimal())
        .toPrecision(contractInfo?.multiplier.numDecimalPlaces() ?? 2);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model.symbol, style: AppTextStyle.f_15_500.color111111),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.h, vertical: 2.h),
                    margin: EdgeInsets.only(left: 6.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: AppColor.colorF5F5F5),
                    child: Text(LocaleKeys.trade6.tr,
                        style: AppTextStyle.f_10_500.color4D4D4D),
                  ),
                  const Spacer(),
                  Text(DateUtil.formatDateMs(model.ctime.toInt()),
                      style: AppTextStyle.f_11_400.color999999),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              getTag(tagArray, sideColor),
              18.verticalSpaceFromWidth,
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('${LocaleKeys.trade27.tr} (${model.symbol.symbolFirst()})',
                    style: leftStyle),
                Text('$dealVolumeStr/$dealVolumeStr', style: rightStyle),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.trade34.tr, style: leftStyle),
                Text(
                    '${model.avgPrice.toPrecision(contractInfo?.coinResultVo?.symbolPricePrecision.toInt() ?? 2)}/${model.type == 2 ? LocaleKeys.trade28.tr : model.price.toPrecision(contractInfo?.coinResultVo?.symbolPricePrecision.toInt() ?? 2)}',
                    style: rightStyle),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(LocaleKeys.trade45.tr, style: leftStyle),
                Text(LocaleKeys.trade46.tr, style: rightStyle),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(LocaleKeys.trade118.tr, style: leftStyle),
              Text(model.getStatusStr(model.status),
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColor.upColor,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget getTag(List<String> array, Color color) {
    return Row(
      children: array
          .map(
            (e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              margin: EdgeInsets.only(right: 6.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: color.withOpacity(0.1),
              ),
              child:
                  Text(e, style: AppTextStyle.f_10_500.copyWith(color: color)),
            ),
          )
          .toList(),
    );
  }
}
