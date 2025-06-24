import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/trade/trade_detail_info.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/coin_info_bottom_sheet.dart';
import 'package:nt_app_flutter/app/ws/contract_socket_manager.dart';
import 'package:nt_app_flutter/app/ws/standard_socket_manager.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../ws/core/model/ws_receive_data.dart';

class TradeDateChangeWidget extends StatefulWidget {
  const TradeDateChangeWidget({super.key, required this.contractInfo});

  final ContractInfo? contractInfo;

  @override
  State<TradeDateChangeWidget> createState() => _TradeDateChangeWidgetState();
}

class _TradeDateChangeWidgetState extends State<TradeDateChangeWidget> {
  Map<String, TradeDetailInfo> map = {};

  @override
  void initState() {
    super.initState();
    if (widget.contractInfo?.subSymbol == null) return;

    if (widget.contractInfo?.contractType == 'E') {
      ContractSocketManager.instance
          .subTradeDetail(widget.contractInfo!.subSymbol, (symbol, data) {
        _handleData(data);
      });
    } else {
      StandardSocketManager.instance.reqTradeDetail(widget.contractInfo!.subSymbol, (symbol, data) {
        _handleData(data);
      });
      StandardSocketManager.instance
          .subTradeDetail(widget.contractInfo!.subSymbol, (symbol, data) {
        _handleData(data);
      });
    }
  }

  _handleData(WSReceiveData receiveData) {
    try {
      Map<String, dynamic> targetData = receiveData.data;
      targetData.forEach((key, value) {
        map[key] = TradeDetailInfo.fromJson(value);
      });
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      Get.log('data ${e.toString()}');
    }
  }

  @override
  void dispose() {
    if (widget.contractInfo?.contractType == 'E') {
      ContractSocketManager.instance
          .unSubDepthTrade(widget.contractInfo?.subSymbol ?? '');
    } else {
      StandardSocketManager.instance
          .unSubDepthTrade(widget.contractInfo?.subSymbol ?? '');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColor.colorBorderGutter, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildItem(
                    LocaleKeys.trade368.tr, map['1d']?.rose?.toDecimal()),
                _buildItem(
                    LocaleKeys.trade369.tr, map['7d']?.rose?.toDecimal()),
                _buildItem(
                    LocaleKeys.trade370.tr, map['30d']?.rose?.toDecimal()),
                _buildItem(
                    LocaleKeys.trade371.tr, map['90d']?.rose?.toDecimal()),
                _buildItem(
                    LocaleKeys.trade372.tr, map['180d']?.rose?.toDecimal()),
                _buildItem(
                    LocaleKeys.trade373.tr, map['1y']?.rose?.toDecimal()),
              ],
            ),
          ),
          26.horizontalSpace,
          _more(),
        ],
      ),
    );
  }

  Widget _more() {
    return InkWell(
      onTap: () {
        CoinInfoBottomSheet.show(contractInfo: widget.contractInfo, map: map);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.public14.tr,
            style: AppTextStyle.f_11_400.colorTextDescription,
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 14.sp,
            color: AppColor.colorABABAB,
          )
        ],
      ),
    );
  }

  Widget _buildItem(String title, Decimal? change) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.f_9_500.colorTextTips,
        ),
        Text(
          change == null
              ? '--'
              : '${(change * 100.toDecimal()).toString().toPrecision(2)}%',
          style: AppTextStyle.f_9_500.copyWith(
            color: (change ?? Decimal.zero) >= Decimal.zero
                ? AppColor.colorFunctionBuy
                : AppColor.colorFunctionSell,
          ),
        ),
      ],
    );
  }
}
