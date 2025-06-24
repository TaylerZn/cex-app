import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

class AssetsTradeModel {
  int tradetype = 0; //0 标准 1 永续 2现货
  ContractInfo? contractInfo;
  MarketInfoModel? marketInfoModel;
  AssetsTradeModel({
    required this.tradetype,
    this.contractInfo,
    this.marketInfoModel,
  });
}
