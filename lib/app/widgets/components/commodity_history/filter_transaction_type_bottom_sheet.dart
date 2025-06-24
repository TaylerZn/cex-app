import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../transaction/bottom_sheet/bottom_sheet_util.dart';
import '../transaction/bottom_sheet/common_bottom_sheet.dart';

/// 交易类型
Future<TransactionType?> showCommodityTransactionTypeBottomSheet(
    {required TransactionType? transactionType}) async {
  List<TransactionType> transactionTypes = [
    TransactionType(LocaleKeys.trade115.tr, null), // 全部
    TransactionType(LocaleKeys.trade131.tr, 1), // 转入
    TransactionType(LocaleKeys.trade132.tr, 2), // 转出
    TransactionType(LocaleKeys.trade133.tr, 3), // 结算多仓
    TransactionType(LocaleKeys.trade134.tr, 4), // 结算多仓
    TransactionType(LocaleKeys.trade135.tr, 5), // 结算多仓
    TransactionType(LocaleKeys.trade136.tr, 6), // 结算多仓
    TransactionType(LocaleKeys.trade137.tr, 7), // 结算多仓
    TransactionType(LocaleKeys.trade138.tr, 8), // 结算多仓
    TransactionType(LocaleKeys.trade139.tr, 9), // 结算多仓
    TransactionType(LocaleKeys.trade392.tr, 13),
  ];

  int selectedIndex =
      transactionTypes.indexWhere((element) => element == transactionType);
  if (selectedIndex == -1) {
    selectedIndex = 0;
  }

  final res = await showBSheet<int?>(
    CommonBottomSheet(
      title: LocaleKeys.trade122.tr,
      items: transactionTypes.map((e) => e.name).toList(),
      selectedIndex: selectedIndex,
    ),
  );
  if (res == null) {
    return null;
  }
  return transactionTypes[res];
}

class TransactionType {
  String name;
  int? type;

  TransactionType(this.name, this.type);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionType &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => name.hashCode ^ type.hashCode;
}
