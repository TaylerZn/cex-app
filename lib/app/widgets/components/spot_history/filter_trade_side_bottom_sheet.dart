
import 'package:get/get.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../transaction/bottom_sheet/bottom_sheet_util.dart';
import '../transaction/bottom_sheet/common_bottom_sheet.dart';

/// 交易方向

Future<SideType?> showTradeSideBottomSheet(
    { required SideType? side}) async {

  List<SideType> sides = [SideType(LocaleKeys.trade115.tr, null), SideType(LocaleKeys.trade47.tr, 'BUY'), SideType(LocaleKeys.trade48.tr, 'SELL')];
  int selectedIndex = sides.indexWhere((element) => element == side);
  if(selectedIndex == -1) {
    selectedIndex = 0;
  }
  final res = await showBSheet<int?>(
    CommonBottomSheet(
      title: LocaleKeys.trade117.tr,
      items: sides.map((e) => e.name).toList(),
      selectedIndex: selectedIndex,
    ),
  );
  if(res != null) {
    return sides[res];
  }
  return null;
}

class SideType {
  String name;
  String? side;

  SideType(this.name, this.side);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SideType &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          side == other.side;

  @override
  int get hashCode => name.hashCode ^ side.hashCode;
}