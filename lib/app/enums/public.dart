// 需要选用哪种 代币 计算价格
import 'package:decimal/decimal.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/public_Getx.dart';

enum IsRateEnum {
  usdt,
  btc;

  Decimal get price => [
        Decimal.parse(AssetsGetx.to.rateUsdtPrice),
        Decimal.parse(AssetsGetx.to.rateBtcPrice),
      ][index];
}
