import 'package:nt_app_flutter/generated/locales.g.dart';

enum StandPriceType {
  limit(LocaleKeys.trade73, 1),
  market(LocaleKeys.trade74, 2);

  final String title;
  final int type;

  const StandPriceType(this.title, this.type);

  static StandPriceType fromIndex(int index) => StandPriceType.values[index];
}

extension PriceTypeExtension on StandPriceType {
  int get index => StandPriceType.values.indexOf(this);
}
