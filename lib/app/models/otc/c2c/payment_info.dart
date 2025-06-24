// To parse this JSON data, do
//
//     final paymentInfo = paymentInfoFromJson(jsonString);

import 'dart:convert';

List<PaymentInfo> paymentInfoFromJson(String str) => List<PaymentInfo>.from(json.decode(str).map((x) => PaymentInfo.fromJson(x)));

String paymentInfoToJson(List<PaymentInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentInfo {
  String? paymentTitle;
  int? id;
  String? payment;
  String? userName;
  String? account;
  String? bankName;
  String? remark;
  String? qrCodeUrl;
  String? cryptoAccount;

  PaymentInfo({
    this.paymentTitle,
    this.id,
    this.payment,
    this.userName,
    this.account,
    this.bankName,
    this.remark,
    this.qrCodeUrl,
    this.cryptoAccount,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
    paymentTitle: json["paymentTitle"],
    id: json["id"],
    payment: json["payment"],
    userName: json["userName"],
    account: json["account"],
    bankName: json["bankName"],
    cryptoAccount:json['cryptoAccount'],
    remark: json["remark"],
    qrCodeUrl: json["qrCodeUrl"],
  );

  Map<String, dynamic> toJson() => {
    "paymentTitle": paymentTitle,
    "id": id,
    'cryptoAccount':cryptoAccount,
    "payment": payment,
    "userName": userName,
    "account": account,
    "bankName": bankName,
    "remark": remark,
    "qrCodeUrl": qrCodeUrl,
  };
}
