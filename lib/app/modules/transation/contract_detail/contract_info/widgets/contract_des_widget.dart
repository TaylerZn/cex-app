import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/commodity/commodity_api.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/contract_info/widgets/stock_info_widget.dart';

import '../../../../../models/contract/res/coin_info.dart';
import '../../../../../models/contract/res/stock_info.dart';
import 'coin_info_widget.dart';

class ContractDesWidget extends StatefulWidget {
  const ContractDesWidget({super.key, required this.contractInfo});

  final ContractInfo? contractInfo;

  @override
  State<ContractDesWidget> createState() => _ContractDesWidgetState();
}

class _ContractDesWidgetState extends State<ContractDesWidget> {
  CoinInfo? _coinInfo;
  StockInfo? _stockInfo;

  @override
  void initState() {
    super.initState();
    if (widget.contractInfo == null) {
      return;
    }
    _fetch();
  }

  _fetch() async {
    try {
      EasyLoading.show();
      final res = await CommodityApi.instance().getCoinMarketInfo(
          widget.contractInfo?.base ?? '', widget.contractInfo!.kind.toInt());
      if (mounted) {
        setState(() {
          try {
            if (widget.contractInfo?.kind.toInt() == 0) {
              _coinInfo = CoinInfo.fromJson(res);
            } else {
              _stockInfo = StockInfo.fromJson(res);
            }
          } on Exception catch (e) {
            Get.log('e ${e.toString()}');
          }
        });
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_coinInfo != null) {
      return CoinInfoWidget(
        coinInfo: _coinInfo!,
        contractInfo: widget.contractInfo!,
      );
    }
    if (_stockInfo != null) {
      return StockInfoWidget(
          stockInfo: _stockInfo!, contractInfo: widget.contractInfo!);
    }
    return Container();
  }
}
