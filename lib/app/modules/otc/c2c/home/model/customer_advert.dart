import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CustomerAdvertListModel with PagingModel, PagingError {
  num? total;
  List<CustomerAdvertModel>? records;

  CustomerAdvertListModel({this.total, this.records});

  CustomerAdvertListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['records'] != null) {
      records = <CustomerAdvertModel>[];
      json['records'].forEach((v) {
        records!.add(CustomerAdvertModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['total'] = total;
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerAdvertModel with PagingModel {
  String? username;
  num? advTime;
  String? side;
  String? coin;
  num? volume;
  num? limitTime;
  String? payCoin;
  bool? enable;
  List<PaymentModel>? payments;
  num? maxTrade;
  num? minTrade;
  num? price;
  num? successDealRate;
  num? successDealTotal;
  String? avatar;
  num? userId;
  num? id;
  num? remainCount;
  num? remainValue;
  num? tradedCount;
  num? tradedValue;
  String? coinIcon;

  num? totalPrice;
  String? paySymbol;

  CustomerAdvertModel(
      {this.username,
      this.advTime,
      this.side,
      this.coin,
      this.volume,
      this.limitTime,
      this.payCoin,
      this.enable,
      this.payments,
      this.maxTrade,
      this.minTrade,
      this.price,
      this.successDealRate,
      this.successDealTotal,
      this.avatar,
      this.userId,
      this.id,
      this.remainCount,
      this.remainValue,
      this.tradedCount,
      this.tradedValue,
      this.coinIcon,
      this.totalPrice,
      this.paySymbol});

  CustomerAdvertModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    advTime = json['advTime'];
    side = json['side'];
    coin = json['coin'];
    volume = json['volume'];
    limitTime = json['limitTime'];
    payCoin = json['payCoin'];
    enable = json['enable'];
    if (json['payments'] != null) {
      payments = <PaymentModel>[];
      json['payments'].forEach((v) {
        payments!.add(PaymentModel.fromJson(v));
      });
    }
    maxTrade = json['maxTrade'];
    minTrade = json['minTrade'];
    price = json['price'];
    successDealRate = json['successDealRate'];
    successDealTotal = json['successDealTotal'];
    avatar = json['avatar'];
    userId = json['userId'];
    id = json['id'];
    remainCount = json['remainCount'];
    remainValue = json['remainValue'];
    tradedCount = json['tradedCount'];
    tradedValue = json['tradedValue'];

    coinIcon = json['coinIcon'];
    totalPrice = json['totalPrice'];
    paySymbol = json['paySymbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['username'] = username;
    data['advTime'] = advTime;
    data['side'] = side;
    data['coin'] = coin;
    data['volume'] = volume;
    data['limitTime'] = limitTime;
    data['payCoin'] = payCoin;
    data['enable'] = enable;
    if (payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    data['maxTrade'] = maxTrade;
    data['minTrade'] = minTrade;
    data['price'] = price;
    data['successDealRate'] = successDealRate;
    data['successDealTotal'] = successDealTotal;
    data['avatar'] = avatar;
    data['userId'] = userId;
    data['id'] = id;
    data['remainCount'] = remainCount;
    data['remainValue'] = remainValue;
    data['tradedCount'] = tradedCount;
    data['tradedValue'] = tradedValue;
    data['coinIcon'] = coinIcon;
    data['totalPrice'] = totalPrice;
    data['paySymbol'] = paySymbol;

    return data;
  }

  String get usernameStr => username != null ? username! : ' ';
  String get icon => String.fromCharCode(usernameStr.runes.first);
  String get dealStr => '${getmConvert(successDealTotal, pricePrecision: 0)}/${getmConvert((successDealRate ?? 0) * 100)}%';
  String get paySymbolStr => paySymbol ?? '';
  String get totalPriceStr => price != null ? price.toString() : '';
  String get volumeStr => '${getmConvert(remainCount)} USDT';
  String get limitStr => '$paySymbolStr${getmConvert(minTrade)} - $paySymbolStr${getmConvert(maxTrade)}';
  bool get isBuy => side == 'SELL';
  bool get isEnable => enable == true;

  String get buttomTitle {
    if (isEnable) {
      return isBuy ? LocaleKeys.c2c191.tr : LocaleKeys.c2c192.tr;
    } else {
      return LocaleKeys.c2c291.tr;
    }
  }
}

class CustomerAdvertDetailModel with PagingModel, PagingError {
  num remainValue = 0;
  List<PaymentModel>? paymentList;
  num? successDealRate;
  num? successDealTotal;
  String? payment;
  num remainCount = 0;
  num maxTrade = 0;
  num minTrade = 0;
  num maxCount = 0;
  num minCount = 0;

  num? limitTime;
  String? description;
  num price = 0;
  String? avatar;
  String? username;
  num? userId;
  num? id;
  num? tradedCount;
  num? tradedValue;
  num currentUserBalance = 0;
  String? side;
  String? coin;
  String? coinSymbol;
  var avaiableNum = ''.obs;
  String payCoin = '';
  num textValue = 0;
  var userBalanceStr = ''.obs;

  CustomerAdvertDetailModel(
      {this.remainValue = 0,
      this.paymentList,
      this.successDealRate,
      this.successDealTotal,
      this.payment,
      this.remainCount = 0,
      this.maxTrade = 0,
      this.minTrade = 0,
      this.limitTime,
      this.description,
      this.price = 0,
      this.avatar,
      this.username,
      this.userId,
      this.id,
      this.tradedCount,
      this.tradedValue,
      this.currentUserBalance = 0,
      this.side,
      this.coin,
      this.coinSymbol});

  CustomerAdvertDetailModel.fromJson(Map<String, dynamic> json) {
    remainValue = json['remainValue'] ?? 0;
    if (json['paymentList'] != null) {
      paymentList = <PaymentModel>[];
      json['paymentList'].forEach((v) {
        paymentList!.add(PaymentModel.fromJson(v));
      });
    }
    successDealRate = json['successDealRate'];
    successDealTotal = json['successDealTotal'];
    payment = json['payment'];
    remainCount = json['remainCount'] ?? 0;
    maxTrade = json['maxTrade'] ?? 0;
    minTrade = json['minTrade'] ?? 0;

    maxCount = json['maxCount'] ?? 0;
    minCount = json['minCount'] ?? 0;

    limitTime = json['limitTime'];
    description = json['description'];
    price = json['price'] ?? 0;
    avatar = json['avatar'];
    username = json['username'];
    userId = json['userId'] ?? 0;
    id = json['id'];
    tradedCount = json['tradedCount'];
    tradedValue = json['tradedValue'];
    currentUserBalance = json['currentUserBalance'] ?? 0;
    side = json['side'];
    coin = json['coin'];
    coinSymbol = json['coinSymbol'];
    payCoin = json['payCoin'] ?? '';
    userBalanceStr.value = userBalance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['remainValue'] = remainValue;
    if (paymentList != null) {
      data['paymentList'] = paymentList!.map((v) => v.toJson()).toList();
    }
    data['successDealRate'] = successDealRate;
    data['successDealTotal'] = successDealTotal;
    data['payment'] = payment;
    data['remainCount'] = remainCount;
    data['maxTrade'] = maxTrade;
    data['minTrade'] = minTrade;

    data['maxCount'] = maxCount;
    data['minCount'] = minCount;

    data['limitTime'] = limitTime;
    data['description'] = description;
    data['price'] = price;
    data['avatar'] = avatar;
    data['username'] = username;
    data['userId'] = userId;
    data['id'] = id;
    data['tradedCount'] = tradedCount;
    data['tradedValue'] = tradedValue;
    data['currentUserBalance'] = currentUserBalance;
    data['side'] = side;
    data['coin'] = coin;
    data['coinSymbol'] = coinSymbol;
    data['payCoin'] = payCoin;

    return data;
  }

  String get usernameStr => username != null ? username! : '--';
  String get limitTimeStr => limitTime != null ? '${limitTime!}${LocaleKeys.c2c209.tr}' : '--';

  String get coinStr => coin != null ? coin! : 'USDT';
  String get coinSymbolStr => coinSymbol ?? '';
  String get priceStr => '/$coinSymbolStr${getmConvert(price)}';

  String get limitAmountStr => isBUy ? limitBuyStr : limitSellStr;
  String get limitBuyStr =>
      '${LocaleKeys.c2c212.tr}: $coinSymbolStr${getmConvert(minTrade)} - $coinSymbolStr${getmConvert(maxTrade)}';
  String get limitSellStr => (textValue > currentUserBalance)
      ? LocaleKeys.c2c379.tr
      : '${LocaleKeys.c2c194.tr}${LocaleKeys.c2c195.tr}: ${getmConvert(minCount)} - ${getmConvert(maxCount)} USDT';

  num get maxTradeNum => isBUy ? maxTrade : maxCount;
  num get minTradeNum => isBUy ? minTrade : minCount;

  num get remainValueNum => isBUy
      ? remainValue
      : remainCount > currentUserBalance
          ? currentUserBalance
          : remainCount;

  String get userBalance => '${getmConvert(currentUserBalance)} USDT≈${getmConvert(currentUserBalance * price)} $payCoin';

  set valueNum(num value) {
    textValue = value;
    if (value == 0) {
      avaiableNum.value = '';
    } else {
      if (isBUy) {
        avaiableNum.value = '${LocaleKeys.c2c213.tr} ${getmConvert(value / price)} USDT';
      } else {
        avaiableNum.value = '${LocaleKeys.c2c213.tr} ${getmConvert(value * price)} $payCoin';
      }
    }
  }

  bool get isBUy => side == 'SELL';
  String get sideStr => side == null
      ? ''
      : isBUy
          ? LocaleKeys.c2c191.tr
          : LocaleKeys.c2c192.tr;
}

///currentUserBalance
class PaymentModel {
  String? account;
  String? userName;
  String? qrcodeImg;
  String? remark;
  String? bankName;
  String? key;
  String? title;
  String? icon;
  String? payment;

  PaymentModel({this.account, this.userName, this.qrcodeImg, this.remark, this.bankName, this.key, this.title, this.icon});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    userName = json['userName'];
    qrcodeImg = json['qrcodeImg'];
    remark = json['remark'];
    bankName = json['bankName'];
    key = json['key'];
    title = json['title'];
    icon = json['icon'];
    payment = json['payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['account'] = account;
    data['userName'] = userName;
    data['qrcodeImg'] = qrcodeImg;
    data['remark'] = remark;
    data['bankName'] = bankName;
    data['key'] = key;
    data['title'] = title;
    data['icon'] = icon;
    data['payment'] = payment;

    return data;
  }

  String get usernameStr => userName != null ? userName! : '--';
  String get accountStr => account != null ? account! : '--';
  String get bankNameStr => bankName != null ? bankName! : '--';
  String get paymentKeyStr => payment != null ? payment! : '';
}

class CustomerAdvertRefreshModel {
  num? price;
  num? minTrade;
  num? maxTrade;
  num? remainCount;
  num? remainValue;
  num? tradedValue;
  num? tradedCount;

  CustomerAdvertRefreshModel(
      {this.price, this.minTrade, this.maxTrade, this.remainCount, this.remainValue, this.tradedValue, this.tradedCount});

  CustomerAdvertRefreshModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    minTrade = json['minTrade'];
    maxTrade = json['maxTrade'];
    remainCount = json['remainCount'];
    remainValue = json['remainValue'];
    tradedValue = json['tradedValue'];
    tradedCount = json['tradedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['price'] = price;
    data['minTrade'] = minTrade;
    data['maxTrade'] = maxTrade;
    data['remainCount'] = remainCount;
    data['remainValue'] = remainValue;
    data['tradedValue'] = tradedValue;
    data['tradedCount'] = tradedCount;
    return data;
  }
}

class CustomerAdvertTradeModel {
  num? id;
  String? sequence;
  num? totalPrice;
  num? volume;
  num? price;
  var isCreateOrder = true;

  int? status;
  String? side;

  bool get isBUy => side == 'BUY';

  CustomerAdvertTradeModel({this.id, this.sequence, this.totalPrice, this.volume, this.price});

  CustomerAdvertTradeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sequence = json['sequence'];
    totalPrice = json['totalPrice'];
    volume = json['volume'];
    price = json['price'];
    isCreateOrder = json['isCreateOrder'];
    status = json['status'];
    side = json['side'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['sequence'] = sequence;
    data['totalPrice'] = totalPrice;
    data['volume'] = volume;
    data['price'] = price;
    data['isCreateOrder'] = isCreateOrder;
    data['status'] = status;
    data['side'] = side;

    return data;
  }
}
