import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/commodity/res/commodity_open_time.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../models/contract/res/public_info.dart';

class ContractInfoController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  static ContractInfoController get to => Get.find();

  ContractInfo? contractInfo;
  CommodityOpenTime? openTime = CommodityOpenTime();

  ContractInfoController(this.contractInfo, this.openTime);

  int tabIndex = 0;

  /// 合约类型
  List list = [0, 1, 5];

  @override
  void onInit() {
    super.onInit();
    int index = list.contains(contractInfo?.kind) ? 0 : 1;
    tabController = TabController(length: 5- index, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  changeContractInfo(ContractInfo contractInfo) {
    this.contractInfo = contractInfo;
    tabIndex = 0;
    tabController.index = 0;
    update();
  }

  changeOpenTime(CommodityOpenTime openTime) {
    this.openTime = openTime;
  }

  // 格式化时间
  String getHourMinute(timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return  DateUtil.formatDateMs(timestamp, isUtc: true, format: 'HH:mm');
  }

  // 生成交易状态文本
  String tradeStateText(OpenTimeTradePeriod item, String? timeZone) {
     String tradeTime = '';
    switch (item.state) {
      case 'PART_DAY_OPEN':
        if (item.startTime != null && item.endTime != null) {
          tradeTime += getHourMinute(item.startTime);
          tradeTime += '-${getHourMinute(item.endTime)}';
        }
        if (item.endTime2 != null && item.startTime2 != null) {
          tradeTime += '/${getHourMinute(item.startTime2)}';
          tradeTime += '-${getHourMinute(item.endTime2)}';
        }
        if (tradeTime.isNotEmpty) {
          tradeTime += ' ($timeZone)';
        }
        break;
      case 'FULL_DAY_OPEN':
        tradeTime = '00:00-23:59';
        break;
      case 'FULL_DAY_CLOSE':
        tradeTime = LocaleKeys.trade14.tr;
        break;
      default:
        tradeTime = '';
    }
    return tradeTime;
  }

  // 检查日期是否是今天
  bool isDay(int? dayOfWeek) {
    return dayOfWeek == DateTime.now().weekday;
  }

  // 获取信息列表
  List<OpenTimeTradePeriod> getInfoList() {
    final CommodityOpenTime timeList = openTime ?? CommodityOpenTime();
    if (ObjectUtil.isNotEmpty(timeList.tradePeriods)) {
      return timeList.tradePeriods!
          .map((OpenTimeTradePeriod item) => OpenTimeTradePeriod(
                dayOfWeek: item.dayOfWeek,
                value: tradeStateText(item, timeList.timeZone),
              ))
          .toList();
    }
    if (timeList.fullTime == true) {
      return [
        OpenTimeTradePeriod(value: '00:00-23:59', dayOfWeek: 1),
        OpenTimeTradePeriod(value: '00:00-23:59', dayOfWeek: 2),
        OpenTimeTradePeriod(value: '00:00-23:59', dayOfWeek: 3),
        OpenTimeTradePeriod(value: '00:00-23:59', dayOfWeek: 4),
        OpenTimeTradePeriod(value: '00:00-23:59', dayOfWeek: 5),
        OpenTimeTradePeriod(value: '00:00-23:59', dayOfWeek: 6),
        OpenTimeTradePeriod(value: '00:00-23:59', dayOfWeek: 7),
      ];
    }
    return [
      OpenTimeTradePeriod(dayOfWeek: 1, value: ''),
      OpenTimeTradePeriod(dayOfWeek: 2, value: ''),
      OpenTimeTradePeriod(dayOfWeek: 3, value: ''),
      OpenTimeTradePeriod(dayOfWeek: 4, value: ''),
      OpenTimeTradePeriod(dayOfWeek: 5, value: ''),
      OpenTimeTradePeriod(dayOfWeek: 6, value: ''),
      OpenTimeTradePeriod(dayOfWeek: 7, value: ''),
    ];
  }

  getTimeName(dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return LocaleKeys.trade235.tr;
      case 2:
        return LocaleKeys.trade236.tr;
      case 3:
        return LocaleKeys.trade237.tr;
      case 4:
        return LocaleKeys.trade238.tr;
      case 5:
        return LocaleKeys.trade239.tr;
      case 6:
        return LocaleKeys.trade240.tr;
      case 7:
        return LocaleKeys.trade241.tr;

      default:
        return '';
    }
  }

  void changeTabIndex(int i) {
    tabIndex = i;
    update();
  }
}
