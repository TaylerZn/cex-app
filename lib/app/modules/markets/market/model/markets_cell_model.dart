import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/models/commodity/res/commodity_public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:intl/intl.dart';

enum ContractBlockType {
  blockUnkonw,
  blockUsdt,
  blockInverse,
  blockStand,
  blockSimulation,
  blockAll;
}

class MarketsCellModel extends GetxController {
  List<ContractGroupList>? commodityGroudList;
  List<ContractInfo>? contractList;
  List<MarketInfoModel>? marketList;
  List<ContractInfo>? commodityList;
}

mixin TickerMixin {
  String esPrice = '0';
  String close = '0';
  String rose = '0';
  String vol = '0';
  String amount = "";
  String high = "";
  String low = "";
  String open = "";
  String ticker = "";
  String firstName = '';
  String secondName = '';
  Color priceColor = Colors.black;
  num precisionNum = 2;
  String coinAliasStr = '';
  //02
  var selected = true.obs;
  int index = 0;
  String type = '';

  String get priceStr {
    if (close.isNotEmpty && close.toNum() > 0) {
      return getPrice(close.toNum(), precisionNum);
    } else {
      return '--';
    }
  }

  String get desPriceStr {
    if (close.isNotEmpty && close.toNum() > 0) {
      var coin = AssetsGetx.to.rateLogo;
      var resClose = close.toNum() * AssetsGetx.to.rateUsdtPrice.toNum();
      return '$coin${getPrice(resClose, precisionNum)}';
    } else {
      return '--';
    }
  }

  /// 这里要在渲染backcolor 时获取，在渲染rosestr时再计算 backcolor已经渲染过去了，还是显示之前的color
  Color get backColor {
    if (rose.isEmpty) {
      return AppColor.colorBackgroundDisabled;
    }
    if (rose.toNum() > 0) {
      return AppColor.colorFunctionBuy;
    } else if (rose.toNum() < 0) {
      return AppColor.colorFunctionSell;
    } else {
      return AppColor.colorBackgroundDisabled;
    }
  }

  String get roseStr {
    if (rose.isEmpty) {
      return '--';
    } else {
      String roseStr = (rose.toNum() * 100).toString().toPrecision(2);
      if (roseStr.toDecimal() == Decimal.zero) {
        return "0.00%";
      } else if (roseStr.toDecimal() < Decimal.zero) {
        return '$roseStr%';
      } else {
        return '+$roseStr%';
      }
    }
  }

  String get volStr {
    if (type == 'B_2' || type == 'B_3' || type == 'B_4') {
      return '';
    } else if (type == 'B_1' || type == 'B_5') {
      return coinAliasStr;
    } else {
      if (vol.isNotEmpty && vol.toNum() > 0) {
        return formatterNum(vol.toNum(), 2);
        // return formatterNum(vol.toNum() * close.toNum(), 2);
      } else {
        return '--';
      }
    }
  }

  set splitName(String name) {
    if (type == 'B_3') {
      if (name.contains('-')) {
        var array = name.split('-');
        firstName = array.first;
        firstName = firstName.split(array.last).first;

        secondName = '/${array.last}';
      }
    } else if (type == 'B_1') {
      if (name.contains('-')) {
        var array = name.split('-');
        firstName = array.first;
        secondName = '';
      }
    } else if (type == 'B_5') {
      if (name.contains('-')) {
        var array = name.split('-');
        firstName = array.first;
        secondName = '/${array.last}';
      }
    } else {
      if (name.contains('/')) {
        var array = name.split('/');
        firstName = array.first;
        secondName = '/${array.last}';
      } else if (name.contains('-')) {
        var array = name.split('-');
        firstName = array.first;
        secondName = '/${array.last}';
      } else {
        firstName = name;
        secondName = '';
      }
    }
  }

  String getPrice(num price, num d) {
    String f = List<String>.generate(d.toInt(), (int index) => '0').join();
    return NumberFormat("#,##0.$f", "en_US").format(price);
  }
}
String formatterNum(dynamic num, [int digits = 1]) {
  const si = [
    {'value': 1, 'unit': ''},
    {'value': 1e3, 'unit': 'K'},
    {'value': 1e6, 'unit': 'M'},
    {'value': 1e9, 'unit': 'G'},
    {'value': 1e12, 'unit': 'T'},
    {'value': 1e15, 'unit': 'P'},
    {'value': 1e18, 'unit': 'E'},
  ];
  var rx = RegExp(r'\.0+$|(?<=\.[0-9]*[1-9])0+$');
  dynamic abs = num.abs();
  for (int i = si.length - 1; i > 0; i--) {
    if (abs >= si[i]['value']) {
      return (num / si[i]['value']).toStringAsFixed(digits).replaceAll(rx, '') + si[i]['unit'];
    }
  }
  return num.toStringAsFixed(digits).replaceAll(rx, '');
}
