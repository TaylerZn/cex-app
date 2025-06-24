import 'dart:ui';

import 'package:flutter_draggable_gridview/constants/colors.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_advert.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_model.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CustomerOrderTradeModel {
  List<Orders>? orders;

  CustomerOrderTradeModel({this.orders});

  CustomerOrderTradeModel.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  String? coin;
  Buyer? buyer;
  Buyer? seller;
  String? createTime;
  List<PaymentModel>? payments;
  num? price;
  String? endTime;
  num? volume;
  num? totalPrice;
  String? sequence;
  num? id;

  Orders(
      {this.coin,
      this.buyer,
      this.seller,
      this.createTime,
      this.payments,
      this.price,
      this.endTime,
      this.volume,
      this.totalPrice,
      this.sequence,
      this.id});

  Orders.fromJson(Map<String, dynamic> json) {
    coin = json['coin'];
    buyer = json['buyer'] != null ? new Buyer.fromJson(json['buyer']) : null;
    seller = json['seller'] != null ? new Buyer.fromJson(json['seller']) : null;
    createTime = json['createTime'];
    if (json['payments'] != null) {
      payments = <PaymentModel>[];
      json['payments'].forEach((v) {
        payments!.add(new PaymentModel.fromJson(v));
      });
    }
    price = json['price'];
    endTime = json['endTime'];
    volume = json['volume'];
    totalPrice = json['totalPrice'];
    sequence = json['sequence'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['coin'] = coin;
    if (this.buyer != null) {
      data['buyer'] = buyer!.toJson();
    }
    if (this.seller != null) {
      data['seller'] = seller!.toJson();
    }
    data['createTime'] = createTime;
    if (this.payments != null) {
      data['payments'] = payments!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['endTime'] = endTime;
    data['volume'] = volume;
    data['totalPrice'] = totalPrice;
    data['sequence'] = sequence;
    data['id'] = id;
    return data;
  }
}

class Buyer {
  final int? uid;
  final String? realName;
  final String? otcNickName;
  final String? mobileNumber;
  final String? imageUrl;
  final int? isOnline;
  final int? completeOrders;
  final int? companyLevel;
  final String? email;

  Buyer({
    this.uid,
    this.realName,
    this.otcNickName,
    this.mobileNumber,
    this.imageUrl,
    this.isOnline,
    this.completeOrders,
    this.companyLevel,
    this.email,
  });

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
        uid: json["uid"],
        realName: json["realName"],
        otcNickName: json["otcNickName"],
        mobileNumber: json["mobileNumber"],
        imageUrl: json["imageUrl"],
        isOnline: json["isOnline"],
        completeOrders: json["completeOrders"],
        companyLevel: json["companyLevel"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "realName": realName,
        "otcNickName": otcNickName,
        "mobileNumber": mobileNumber,
        "imageUrl": imageUrl,
        "isOnline": isOnline,
        "completeOrders": completeOrders,
        "companyLevel": companyLevel,
        "email": email,
      };
}

//2

class CustomerOrderDetailModel with PagingModel {
  List<PaymentModel>? payment;
  Buyer? buyer;
  Buyer? seller;
  String? coin;
  num? ctime;
  num? price;
  num? volume;
  num? totalPrice;
  String? sequence;
  num? id;
  num? idNum;
  String? side;
  String? paySymbol;
  String? paymentCn;
  String? description;
  PaymentModel? orderPayment;
  int? payTime;
  String? sideText;
  String? buyerComplainTimeStart;
  num? complainId;
  String? paycoin;
  String? sellerComplainTimeStart;
  String? payKey;

  ///
  /// 订单状态 待支付1 已支付2 交易成功3 取消4 申诉5 打币中6 异常订单7 申诉处理完成 8 申诉取消 9
  int? status;
  int? sellerTimeOffset;
  int? buyerTimeOffset;
  bool? isMerchant;
  var isSelected = false.obs;
  // 1买家取消 2申诉判断定卖家未付款 3 超时未支付取消
  int? cancelStatus;
  num? complainUserId;
  num? toComplainId;

  //time
  num limitTime = 0;
  num remainTime = 0;

  CustomerOrderDetailModel({
    this.payment,
    this.buyer,
    this.seller,
    this.coin,
    this.ctime,
    this.price,
    this.volume,
    this.totalPrice,
    this.sequence,
    // this.id,
    this.side,
    this.paySymbol,
    this.payTime,
    this.sideText,
    this.isMerchant,
    this.buyerComplainTimeStart,
    this.complainId,
    this.paycoin,
    this.sellerComplainTimeStart,
    this.status,
    this.paymentCn,
    this.description,
    this.payKey,
    this.cancelStatus,
  });

  CustomerOrderDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['payment'] != null) {
      payment = <PaymentModel>[];
      json['payment'].forEach((v) {
        payment!.add(PaymentModel.fromJson(v));
      });
    }
    buyerTimeOffset = json['buyerTimeOffset'];
    sellerTimeOffset = json['sellerTimeOffset'];
    isMerchant = json['isMerchant'];
    orderPayment = json['orderPayment'] != null ? PaymentModel.fromJson(json['orderPayment']) : null;
    buyer = json['buyer'] != null ? Buyer.fromJson(json['buyer']) : null;
    seller = json['seller'] != null ? Buyer.fromJson(json['seller']) : null;
    coin = json['coin'];
    ctime = json['ctime'];
    price = json['price'];
    volume = json['volume'];
    totalPrice = json['totalPrice'];
    sequence = json['sequence'];
    // id = json['id'];
    paySymbol = json['paySymbol'];
    side = json['side'];
    payTime = json['payTime'];
    sideText = json['sideText'];
    buyerComplainTimeStart = json['buyerComplainTimeStart'];
    complainId = json['complainId'];
    paycoin = json['paycoin'];
    sellerComplainTimeStart = json['sellerComplainTimeStart'];
    status = json['status'];
    paymentCn = json['paymentCn'];
    description = json['description'];
    limitTime = json['limitTime'] ?? 900000;
    remainTime = json['remainTime'] ?? 900000;
    payKey = json['payKey'];
    cancelStatus = json['cancelStatus'];
    complainUserId = json['complainUserId'];
    toComplainId = json['toComplainId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (payment != null) {
      data['payment'] = payment!.map((v) => v.toJson()).toList();
    }
    if (buyer != null) {
      data['buyer'] = buyer!.toJson();
    }
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    if (orderPayment != null) {
      data['orderPayment'] = orderPayment!.toJson();
    }
    data['coin'] = coin;
    data['ctime'] = ctime;
    data['price'] = price;
    data['volume'] = volume;
    data['totalPrice'] = totalPrice;
    data['sequence'] = sequence;
    // data['id'] = id;
    data['paySymbol'] = paySymbol;
    data['side'] = side;
    data['paymentCn'] = paymentCn;
    data['description'] = description;
    data['remainTime'] = remainTime;
    data['payKey'] = payKey;
    data['cancelStatus'] = cancelStatus;
    data['complainUserId'] = complainUserId;
    data['toComplainId'] = toComplainId;

    return data;
  }

  bool get isBUy {
    if (isMerchant == true) {
      return side != 'SELL';
    } else {
      return side == 'SELL';
    }
  }

  String get sideStr => side == null
      ? ''
      : isBUy
          ? LocaleKeys.c2c191.tr
          : LocaleKeys.c2c192.tr;
  String get coinStr => coin != null ? coin! : 'USDT';
  String get sequenceStr => sequence != null ? sequence! : '';
  String get coinSymbolStr => paySymbol ?? '';
  String get priceStr => '$coinSymbolStr${getmConvert(price)}';
  String get volumeStr => '${getmConvert(volume)} $coinStr';
  String get totalPriceStr => '${getmConvert(totalPrice)} $paycoinStr';
  String get paymentStr => paymentCn ?? '--';
  String get paymentUseNameStr => orderPayment != null ? orderPayment!.usernameStr : '';
  String get paymentAccountStr => orderPayment != null ? orderPayment!.accountStr : '';
  String get paymentBankNameStr => orderPayment != null ? orderPayment!.bankNameStr : '';
  String get descriptionStr => description != null ? description! : '';
  String get paymentKeyStr => orderPayment != null ? orderPayment!.paymentKeyStr : '';
  String get createdTime => MyTimeUtil.timestampToStr((ctime ?? 0).toInt());
  String get usdtNum => getmConvert(((totalPrice ?? 0) / (price ?? 1)));
  String get paycoinStr => paycoin != null ? paycoin! : '';
  String get succesSideStr => side == null
      ? ''
      : isBUy
          ? LocaleKeys.c2c248.tr
          : LocaleKeys.c2c275.tr;

  Color get sideStrColor => isBUy ? AppColor.upColor : AppColor.downColor;

  String get useNameStr {
    if (isBUy) {
      return seller?.realName ?? '';
    } else {
      return buyer?.realName ?? '';
    }
  }

  bool get isComplainUser {
    return UserGetx.to.uid == complainUserId;
  }

  /// 订单状态 待支付1 已支付2 交易成功3 取消4 申诉5 打币中6 异常订单7 申诉处理完成 8 申诉取消 9
  String getStateStr() {
    if (isBUy) {
      if (status == 1) {
        return LocaleKeys.c2c283.tr;
      } else if (status == 2) {
        return LocaleKeys.c2c284.tr;
      } else if (status == 3) {
        return LocaleKeys.c2c247.tr;
      } else if (status == 4) {
        return LocaleKeys.c2c287.tr;
      } else if (status == 5) {
        return LocaleKeys.c2c288.tr;
      } else {
        return '';
      }
    } else {
      if (status == 1) {
        return LocaleKeys.c2c268.tr;
      } else if (status == 2) {
        return LocaleKeys.c2c286.tr;
      } else if (status == 3) {
        return LocaleKeys.c2c247.tr;
      } else if (status == 4) {
        return LocaleKeys.c2c287.tr;
      } else if (status == 5) {
        return LocaleKeys.c2c288.tr;
      } else {
        return '';
      }
    }
  }

  int get appealTime => isBUy ? buyerTimeOffset ?? 0 : sellerTimeOffset ?? 0;

  set appealTimeNum(num time) {
    if (isBUy) {
      buyerTimeOffset = time.toInt();
    } else {
      sellerTimeOffset = time.toInt();
    }
  }
}

//3

class CustomerOrderChartModel with PagingModel {
  num? userId;
  String? userName;
  String? avatar;
  String? latestNews;
  num? count;

  CustomerOrderChartModel({this.userId, this.userName, this.avatar, this.latestNews, this.count});

  CustomerOrderChartModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    avatar = json['avatar'];
    latestNews = json['latestNews'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['userId'] = userId;
    data['userName'] = userName;
    data['avatar'] = avatar;
    data['latestNews'] = latestNews;
    data['count'] = count;
    return data;
  }

  String get usernameStr => userName != null ? userName! : '--';
  String get icon => avatar?.isNotEmpty == true ? avatar! : "default/avatar_default".pngAssets();
  String get latestNewsStr => latestNews?.isNotEmpty == true ? latestNews! : '';
  String get countStr => getmConvert(count, pricePrecision: 0);
}

class CustomerOrderModel {
  var chartModel = CustomerOrderChartModel();
  var detailModel = CustomerOrderDetailModel();
  CustomerOrderType type = CustomerOrderType.orderCreate;
}
