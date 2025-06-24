import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../transaction/bottom_sheet/bottom_sheet_util.dart';
import '../transaction/bottom_sheet/common_bottom_sheet.dart';

/// 交易类型
Future<OrderType?> showCommodityOrderTypeBottomSheet(
    {required OrderType orderType}) async {
  List<OrderType> orderTypes = [
    OrderType(LocaleKeys.trade115.tr, null),
    OrderType(LocaleKeys.trade41.tr, 1),
    OrderType(LocaleKeys.trade30.tr, 2),
    OrderType(LocaleKeys.trade288.tr, 3),
  ];

  int selectedIndex = orderTypes.indexWhere((element) => element == orderType);
  if (selectedIndex == -1) {
    selectedIndex = 0;
  }

  final res = await showBSheet<int?>(
    CommonBottomSheet(
      title: LocaleKeys.trade122.tr,
      items: orderTypes.map((e) => e.name).toList(),
      selectedIndex: selectedIndex,
    ),
  );
  if (res == null) {
    return null;
  }
  return orderTypes[res];
}

class OrderType {
  String name;
  int? type;

  OrderType(this.name, this.type);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderType &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => name.hashCode ^ type.hashCode;
}
