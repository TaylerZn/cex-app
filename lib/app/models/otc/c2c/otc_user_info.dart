// To parse this JSON data, do
//
//     final otcUserInfo = otcUserInfoFromJson(jsonString);

import 'dart:convert';

OtcUserInfo otcUserInfoFromJson(String str) => OtcUserInfo.fromJson(json.decode(str));

String otcUserInfoToJson(OtcUserInfo data) => json.encode(data.toJson());

class OtcUserInfo {
  bool? emailStatus;
  String? nickName;
  dynamic headImage;
  bool? phoneStatus;
  Merchant? merchant;
  bool? isMerchant;
  bool? idCardStatus;
  Personal? personal;

  OtcUserInfo({
    this.emailStatus,
    this.nickName,
    this.headImage,
    this.phoneStatus,
    this.merchant,
    this.isMerchant,
    this.idCardStatus,
    this.personal,
  });

  factory OtcUserInfo.fromJson(Map<String, dynamic> json) => OtcUserInfo(
    emailStatus: json["emailStatus"],
    nickName: json["nickName"],
    headImage: json["headImage"],
    personal: json["personal"] == null ? null : Personal.fromJson(json["personal"]),
    phoneStatus: json["phoneStatus"],
    merchant: json["merchant"] == null ? null : Merchant.fromJson(json["merchant"]),
    isMerchant: json["isMerchant"],
    idCardStatus: json["idCardStatus"],
  );

  Map<String, dynamic> toJson() => {
    "emailStatus": emailStatus,
    "nickName": nickName,
    "headImage": headImage,
    "phoneStatus": phoneStatus,
    "merchant": merchant?.toJson(),
    "personal": personal?.toJson(),
    "isMerchant": isMerchant,
    "idCardStatus": idCardStatus,
  };

  String get completeOrderRate {
    if(isMerchant == true){
      return merchant?.completeOrderRate ?? '0%';
    }
    return personal?.completeOrderRate ?? '0%';
  }

  String get payTime {
    if(isMerchant == true){
      return merchant?.payTime ?? '00:00:00';
    }
    return personal?.payTime ?? '00:00:00';
  }

  String get passTime {
    if(isMerchant == true){
      return merchant?.passTime ?? '00:00:00';
    }
    return personal?.passTime ?? '00:00:00';
  }

  String get completeOrders {
    if(isMerchant == true){
      return '${merchant?.completeOrders ?? 0}';// ?? '0%';
    }
    return '${personal?.completeOrders ?? 0}';
  }
}

class Personal {
  String? completeOrderRate;
  String? payTime;
  String? passTime;
  int? completeOrders;

  Personal({
    this.completeOrderRate,
    this.payTime,
    this.passTime,
    this.completeOrders,
  });

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
    completeOrderRate: json["completeOrderRate"],
    payTime: json["payTime"],
    passTime: json["passTime"],
    completeOrders: json["completeOrders"],
  );

  Map<String, dynamic> toJson() => {
    "completeOrderRate": completeOrderRate,
    "payTime": payTime,
    "passTime": passTime,
    "completeOrders": completeOrders,
  };
}

class Merchant {
  String? completeOrderRate;
  String? payTime;
  String? marginAmount;
  int? sellOrders;
  String? passTime;
  int? merchant;
  int? online;
  String? marginCoin;
  int? buyOrders;
  int? completeOrders;
  int? type;

  Merchant(
      {this.completeOrderRate,
      this.payTime,
      this.marginAmount,
      this.sellOrders,
      this.passTime,
      this.merchant,
      this.online,
      this.marginCoin,
      this.buyOrders,
      this.completeOrders,
      this.type});

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        completeOrderRate: json["completeOrderRate"],
        payTime: json["payTime"],
        marginAmount: json["marginAmount"],
        sellOrders: json["sellOrders"],
        passTime: json["passTime"],
        merchant: json["merchant"],
        online: json["online"],
        marginCoin: json["marginCoin"],
        buyOrders: json["buyOrders"],
        completeOrders: json["completeOrders"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "completeOrderRate": completeOrderRate,
        "payTime": payTime,
        "marginAmount": marginAmount,
        "sellOrders": sellOrders,
        "passTime": passTime,
        "merchant": merchant,
        "online": online,
        "marginCoin": marginCoin,
        "buyOrders": buyOrders,
        "completeOrders": completeOrders,
        "type": type,
      };
}
