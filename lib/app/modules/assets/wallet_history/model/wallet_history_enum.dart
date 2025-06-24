import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/assets/wallet_history/model/wallet_history_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//
///TabBar类型 枚举
enum WalletHistoryType {
  topUp,
  withdrawal,
  spotTrading,
  transfer,
  conver,
  bonus;

  String get value => [
        LocaleKeys.assets35.tr,
        LocaleKeys.assets64.tr,
        LocaleKeys.assets120.tr,
        LocaleKeys.assets7.tr,
        LocaleKeys.trade289.tr, //兑换
        LocaleKeys.assets134.tr
      ][index];

  WalletHistoryFilterModel get model => WalletHistoryFilterModel(this);
}

///弹窗类型 枚举
enum WalletHistoryBottomType {
  defaultView,
  selStartTimeView,
  selEndTimeView,
  selectView;
}

enum WalletHistoryTimePickerType {
  selStartTime,
  selEndTime;
}

enum WalletHistoryFilterViewType {
  // 带筛选btn的选择器
  filterPicker,
  // 仅仅选择时间的选择器
  timePicker,
  // 全部按钮 和 筛选按钮
  allBtnFilterPicker;
}
