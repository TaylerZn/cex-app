import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/utils/extension/num_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../utils/utilities/number_util.dart';
import '../../../entrust/model/transaction_historical_model.dart';

class CommodityHistoryTradeItem extends StatelessWidget {
  const CommodityHistoryTradeItem({super.key, required this.item});
  final TransactionHistoricalTransModel item;
  @override
  Widget build(BuildContext context) {
    ContractInfo? contractInfo = CommodityDataStoreController.to
        .getContractInfoByContractId(item.contractId ?? 0);

    Color color = item.side == 'BUY' ? AppColor.upColor : AppColor.downColor;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 16.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${item.base}/${item.quote}',
                style: AppTextStyle.f_16_500.color111111,
              ),
              Text(
                DateUtil.formatDateMs(item.ctime.toInt(),
                    format: 'yyyy-MM-dd HH:mm:ss'),
                style: AppTextStyle.f_12_400.color999999,
              ),
            ],
          ),
          8.verticalSpace,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            margin: EdgeInsets.only(right: 6.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: color.withOpacity(0.1),
            ),
            child: Text(item.getOpenSide(item.open, item.side),
                style: AppTextStyle.f_10_500.copyWith(color: color)),
          ),
          10.verticalSpace,
          getRow(
            '${LocaleKeys.trade34.tr}（${item.quote}）',
            NumberUtil.mConvert(
              item.price,
              count:
                  contractInfo?.coinResultVo?.symbolPricePrecision.toInt() ?? 4,
            ),
          ),
          getRow(
            '${LocaleKeys.trade49.tr} (${item.base})',
            NumberUtil.mConvert(
              (item.volume ?? 0) * (contractInfo?.multiplier ?? 1),
              count: contractInfo?.multiplier.numDecimalPlaces() ?? 2,
            ),
          ),
          getRow(LocaleKeys.trade50.tr, item.role),
          getRow(
            '${LocaleKeys.trade51.tr} (${item.quote})',
            NumberUtil.mConvert(
              item.fee,
              count: item.feeCoinPrecision.toInt(),
            ),
          ),

          /// item.relizedAmount > 0 upcolor < 0 downcolor == 0 color333333
          getRow(
            '${LocaleKeys.trade171.tr}（${item.quote}）',
            NumberUtil.mConvert(item.realizedAmount,
                count:
                    contractInfo?.coinResultVo?.symbolPricePrecision.toInt() ??
                        4),
            item.realizedAmount > 0
                ? AppColor.upColor
                : item.realizedAmount < 0
                    ? AppColor.downColor
                    : AppColor.color333333,
          ),
          // getRow('总价（${item.quoteCoin}）', '≈${item.totalPrice}'),
        ],
      ),
    );
  }

  Widget getRow(String left, String right,
      [Color color = AppColor.color333333]) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(left, style: AppTextStyle.f_12_500.color999999),
          Text(right, style: AppTextStyle.f_12_500.copyWith(color: color)),
        ],
      ),
    );
  }
}
