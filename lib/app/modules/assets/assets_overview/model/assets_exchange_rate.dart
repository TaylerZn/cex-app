import 'package:flutter/widgets.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

enum AssetsOverType {
  deposit,
  withdraw,
  buy,
  transfer;

  String get value => [LocaleKeys.assets35.tr, LocaleKeys.assets53.tr, LocaleKeys.assets144.tr, LocaleKeys.assets7.tr][index];
  String get image => ['asset_deposit', 'asset_withdraw', 'asset_buycoin', 'asset_transfer'][index];
}

// class ExchangeRateFilterModel {
//   List<ExchangeRateType> actionArray = [ExchangeRateType.btc, ExchangeRateType.usdt];
//   int currentIndex = 0;
// }

class AssetsKLIneModel {
  num? id;
  num? uid;
  num totalBalance = 0;
  num? statsDate;
  num? statsHour;
  String? time;
  String? balance;

  AssetsKLIneModel({this.id, this.uid, this.totalBalance = 0, this.statsDate, this.statsHour, this.time, this.balance});

  AssetsKLIneModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    totalBalance = json['totalBalance'] ?? 0;
    statsDate = json['statsDate'];
    statsHour = json['statsHour'];
    time = json['time'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['uid'] = uid;
    data['totalBalance'] = totalBalance;
    data['statsDate'] = statsDate;
    data['statsHour'] = statsHour;
    data['time'] = time;
    data['balance'] = balance;
    return data;
  }
}

class AssetsFiat {
  String? currency;
  String? icon;
  String? countryName;
  String? rate;
  List<String>? payTypeList;

  AssetsFiat({this.currency, this.icon, this.countryName, this.rate, this.payTypeList});

  AssetsFiat.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    icon = json['icon'];
    countryName = json['countryName'];
    rate = json['rate'];
    payTypeList = json['payTypeList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currency'] = currency;
    data['icon'] = icon;
    data['countryName'] = countryName;
    data['rate'] = rate;
    data['payTypeList'] = payTypeList;
    return data;
  }

  String get currencyStr => currency ?? '';
  String get iconStr => icon ?? '';
  String get countryNameStr => countryName ?? '';
  String get rateStr => rate != null ? '1 USDT ≈ $rate $currencyStr' : '';
  List<String> get payTypeArr => payTypeList ?? [];
}

class AssetsAccount with PagingModel {
  String name = '';
  String value = '';
  int precision = 2;
  String rateCoin = '';
  num tabIndex = 0;
  String? pnlRate;
  String? pnl;
  String pieName = '';

  AssetsAccount({this.name = '', this.value = '', this.precision = 2, this.rateCoin = '', this.tabIndex = 0});

  AssetsAccount.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    value = json['value'] ?? '';
    precision = json['precision'] ?? 2;
    rateCoin = json['rateCoin'] ?? '';
    tabIndex = json['tabIndex'] ?? 0;
    pnlRate = json['pnlRate'];
    pnl = json['pnl'];
    pieName = json['pieName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['value'] = value;
    data['precision'] = precision;
    data['rateCoin'] = rateCoin;
    data['tabIndex'] = tabIndex;
    data['pieName'] = pieName;

    return data;
  }

  String get pnlRateStr {
    if (pnl != null && pnlRate != null) {
      if (pnlRate == '--' || pnlRate == '0.00%' || pnlRate == '0') {
        var pnlNum = num.parse(pnl!);
        var pnlStr = pnlNum == 0 ? '\$0.0' : '${pnlNum > 0 ? '+' : ''}\$${getmConvert(pnlNum)}';
        return '$pnlStr (0.0%)';
      } else {
        var pnlNum = num.parse(pnl!);
        var pre = pnlNum > 0 ? '+' : '';
        var pnlStr = pnlNum == 0 ? '\$0.0' : '$pre\$${getmConvert(pnlNum)}';
        if (pnlRate!.contains('%')) {
          return '$pnlStr ($pre$pnlRate)';
        } else {
          return '$pnlStr ($pre${getmConvert(num.parse(pnlRate!))}%)';
        }
      }
    } else {
      return '';
    }
  }

  Color get pnlRateColor {
    if (pnl != null) {
      var pnlNum = num.parse(pnl!);
      if (pnlNum > 0) {
        return AppColor.upColor;
      } else if (pnlNum < 0) {
        return AppColor.downColor;
      } else {
        return AppColor.color666666;
      }
    } else {
      return AppColor.color666666;
    }
  }
}
