import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_public_info.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/entrust_model.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

///筛选项 枚举
enum C2cType {
  buy,
  sell;

  String get value => [LocaleKeys.c2c191.tr, LocaleKeys.c2c192.tr][index];
}

///弹窗类型 枚举
enum CustomerSheetType {
  rateType,
  coinType,
  amountType,
  filterType;
}

class CustomerTocFillterModel {
  List<CountryNumberInfo>? paycoinList;
  List<CountryNumberInfo>? payments;
  String otcDefaultPaycoin = '';

  CustomerSheetType type;
  String title = '';
  List<String> actionArray = [];
  var topTitle = ''.obs;
  var currentIndex = 0.obs;
  List<FilterStateModel> stateArray = [];
  var textVC = TextEditingController().obs;
  var baseAmount = '10';
  var paymentsList = [].obs;

  CustomerTocFillterModel(this.type, {this.paycoinList, this.payments, this.otcDefaultPaycoin = ''}) {
    switch (type) {
      case CustomerSheetType.rateType:
        actionArray = paycoinList == null ? [] : paycoinList!.map((e) => e.key ?? '').toList();
        currentIndex.value = actionArray.contains(otcDefaultPaycoin) ? actionArray.indexOf(otcDefaultPaycoin) : 0;
        topTitle.value = actionArray.isEmpty
            ? '--'
            : actionArray.contains(otcDefaultPaycoin)
                ? otcDefaultPaycoin
                : actionArray[0];

        break;
      case CustomerSheetType.coinType:
        title = LocaleKeys.c2c292.tr;
        actionArray = ['BNB', 'BTC', 'USDT', 'ETH'];
        break;
      case CustomerSheetType.amountType:
        title = LocaleKeys.c2c187.tr;
        topTitle.value = title;
        actionArray = ['1', '5', '10', '20', '50', '100'];
        break;
      default:
        title = LocaleKeys.c2c195.tr;
      // actionArray = payments == null ? [] : payments!.map((e) => e.title ?? '').toList();
    }
  }
}

class CustomerTocRequestModel {
  late CustomerTocFillterModel fiterCoin;
  late CustomerTocFillterModel filterRate;
  late CustomerTocFillterModel filterAmount;
  late CustomerTocFillterModel filter;
  List<CountryNumberInfo>? paycoinList;
  List<CountryNumberInfo>? payments;

  //request
  // var paycoin = 'USD';
  String otcDefaultPaycoin = 'USD';
  var amount = '';
  var tradeType = 0;
  var paymentsList = [];
  var complete = false;
  var filterArray = [false, false];

  Function()? callback;
  CustomerTocRequestModel(
      {this.paycoinList, this.payments, this.otcDefaultPaycoin = '', this.complete = false, this.callback}) {
    filterRate =
        CustomerTocFillterModel(CustomerSheetType.rateType, paycoinList: paycoinList, otcDefaultPaycoin: otcDefaultPaycoin);
    fiterCoin = CustomerTocFillterModel(CustomerSheetType.coinType);
    filterAmount = CustomerTocFillterModel(CustomerSheetType.amountType);
    filter = CustomerTocFillterModel(CustomerSheetType.filterType, payments: payments);
  }

  callbackFilter() {
    filterArray = [true, true];
    callback?.call();
  }
}

class CustomerCoinListModel {
  List<CustomerCoinModel>? records;

  CustomerCoinListModel({this.records});

  CustomerCoinListModel.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <CustomerCoinModel>[];
      json['records'].forEach((v) {
        records!.add(CustomerCoinModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerCoinModel {
  String? coinSymbol;
  String? name;
  String? icon;

  CustomerCoinModel({this.coinSymbol, this.name, this.icon});

  CustomerCoinModel.fromJson(Map<String, dynamic> json) {
    coinSymbol = json['coinSymbol'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['coinSymbol'] = coinSymbol;
    data['name'] = name;
    return data;
  }
}

///弹窗类型 枚举
enum CustomerOrderType {
  orderCreate,
  orderTrade,
  amountType,
  filterType;
}
