
import 'package:nt_app_flutter/generated/locales.g.dart';

enum OrderType {
  limit(LocaleKeys.trade44,1),
  market(LocaleKeys.trade74,2),
  limitStop(LocaleKeys.trade75,1),
  marketStop(LocaleKeys.trade76,2);

  final String title;
  final int type;

  const OrderType(this.title,this.type);
}

extension OrderTypex on OrderType {
  int get index => OrderType.values.indexOf(this);
}