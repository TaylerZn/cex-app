import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

enum C2COrderType{
  all(null),
  purchase('BUY'),
  sell('SELL');
  const C2COrderType(this.key);
  final String? key;
  String title(){
    switch(this){
      case sell:
        return LocaleKeys.c2c13.tr;;
      case purchase:
        return  LocaleKeys.b2c8.tr;
      default:
        return LocaleKeys.c2c147.tr;
    }
  }
}

class C2CFilterBean{
  // String? current
  RxInt current = 0.obs;
  // 开始结束时间
  Rx<DateTime> startTime = MyTimeUtil.old(365).obs;
  Rx<DateTime> endTime = MyTimeUtil.now().obs;
  C2COrderType type(){
    switch(current.value){
      case 1:
        return C2COrderType.purchase;
      case 2:
        return C2COrderType.sell;
      default :
        return C2COrderType.all;
    }
  }
}