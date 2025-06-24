import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class TransactionBaseModel with PagingModel, PagingError {
  int count = 0;
  List? orderList;
}

mixin transactionMixin {
  // 0 初始, 1 新订单, 2 完全成交, 3.失败, 4 已撤销, 5 待撤销, 6.异常订单
  String getStatusStr(num status) {
    switch (status) {
      case 1:
        return LocaleKeys.trade124.tr;
      case 2:
        return LocaleKeys.trade141.tr;
      case 3:
        return LocaleKeys.assets112.tr;
      case 4:
        return LocaleKeys.trade125.tr;
      case 6:
        return LocaleKeys.trade124.tr;
      default:
        return LocaleKeys.trade146.tr;
    }
  }

//订单类型: 1 限价, 2 市价 , 3 IOC，4 FOK，5.POST_ONLY , 6 强制减仓
  String getOrderType(num type) {
    switch (type) {
      case 1:
        return LocaleKeys.trade44.tr;
      case 2:
        return LocaleKeys.trade28.tr;
      case 3:
        return 'IOC';
      case 4:
        return 'FOK';
      case 5:
        return 'POST_ONLY';
      case 6:
        return LocaleKeys.trade147.tr;
      default:
        return '';
    }
  }

//开平仓⽅向(open 开仓，close 平仓) close标识只减仓

// 买卖⽅向（buy 买⼊，sell 卖出）
// 该字段和open字段合并展示; 示例
// 如下:
// open = open , side = buy (开多)
// open = open, side = sell (开空)
// 平仓和开仓方向是反的
// open = close, side = buy(平空) //(平多)
// open = close, side = sell(平多) // (平空)
  String getOpenSide(String open, String side) {
    if (open == 'OPEN' && side == 'BUY') {
      return LocaleKeys.trade22.tr;
    } else if (open == 'OPEN' && side == 'SELL') {
      return LocaleKeys.trade23.tr;
    } else if (open == 'CLOSE' && side == 'BUY') {
      return LocaleKeys.trade26.tr;
    } else if (open == 'CLOSE' && side == 'SELL') {
      return LocaleKeys.trade25.tr;
    } else {
      return '';
    }
  }
}
