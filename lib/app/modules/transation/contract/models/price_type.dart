import 'package:nt_app_flutter/generated/locales.g.dart';

enum StopWinLosePriceType {
  tagPrice(
    1,
    LocaleKeys.trade110,
    LocaleKeys.trade85,
  ),
  lastPrice(2, LocaleKeys.trade275, LocaleKeys.trade84,);

  final int type;
  final String title;
  final String subTitle;
  const StopWinLosePriceType(this.type, this.title, this.subTitle);
}
