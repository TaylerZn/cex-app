import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/model/transaction_model.dart';
import 'package:nt_app_flutter/app/utils/utilities/date_time_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class TransactionFlowFunds extends TransactionBaseModel {
  TransactionFlowFunds();

  TransactionFlowFunds.fromJson(Map<String, dynamic> json) {
    orderList = <TransactionFlowFundsModel>[];
    if (json['transList'] != null) {
      json['transList'].forEach((v) {
        orderList!.add(TransactionFlowFundsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transList'] = orderList != null ? orderList!.map((v) => v.toJson()).toList() : [];
    return data;
  }
}

class TransactionFlowFundsModel with PagingModel {
  String? symbol;
  String? amount;
  String? contractOtherName;
  int? timeLong;
  String? ctime;
  String? contractName;
  int? id;
  String? type;
  String? scene;

  TransactionFlowFundsModel(
      {this.symbol,
      this.amount,
      this.contractOtherName,
      this.timeLong,
      this.ctime,
      this.contractName,
      this.id,
      this.type,
      this.scene});

  TransactionFlowFundsModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    amount = json['amount'];
    contractOtherName = json['contractOtherName'];
    timeLong = json['timeLong'];
    ctime = json['ctime'];
    contractName = json['contractName'];
    id = json['id'];
    type = json['type'];
    scene = json['scene'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['symbol'] = symbol;
    data['amount'] = amount;
    data['contractOtherName'] = contractOtherName;
    data['timeLong'] = timeLong;
    data['ctime'] = ctime;
    data['contractName'] = contractName;
    data['id'] = id;
    data['type'] = type;
    data['scene'] = scene;
    return data;
  }

  String get name => symbol ?? 'USDT';
  String get contractNameStr => contractOtherName?.isNotEmpty == true ? '$contractOtherName ${LocaleKeys.trade7.tr}' : '--';
  String get typeStr => type?.isNotEmpty == true ? type! : '--';
  String get time => MyTimeUtil.timestampToStr((timeLong ?? 0).toInt());
  String get amountStr => getmConvert(num.parse(amount ?? '0'));
}

class TransactionCapitalCost extends TransactionBaseModel {}
