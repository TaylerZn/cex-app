// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/model/follow_setup_enum.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class FollowSetupModel with PagingModel {
  FollowSetupType type;

  var text2 = '0.00'.obs;
  var text3 = '0.00'.obs;
  var hintText = '10-10,000';
  num max = 10000;
  num min = 10;

  FollowInfoModel model = FollowInfoModel();

  final controllerArray = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  FollowSetupModel(this.type) {
    controllerArray[2].addListener(() {
      var text = controllerArray[2].text;

      if (text.isNotEmpty) {
        var value = double.parse(controllerArray[2].text);

        if (value > 90) {
          value = 90;
          controllerArray[2].text = value.toString();
        }

        text2.value = value.toStringAsFixed(2);
      } else {
        text2.value = '0.00';
      }
    });

    controllerArray[3].addListener(() {
      var text = controllerArray[3].text;

      if (text.isNotEmpty) {
        var value = double.parse(controllerArray[3].text);

        // if (value > 100) {
        //   value = 100;
        //   controllerArray[3].text = value.toString();
        // }

        text3.value = value.toStringAsFixed(2);
        // controllerArray[3].text = value.toStringAsFixed(2);
      } else {
        text3.value = '0.00';
      }
    });
  }

  FollowInfoModel get infoModel {
    var array = controllerArray.map((e) => e.text).toList();
    model.singleAmount = array[0].isNotEmpty ? array[0] : '0';
    model.amount = array[1].isNotEmpty ? array[1] : '0';
    model.stopDeficit = array[2].isNotEmpty ? array[2] : '0';
    model.stopProfit = array[3].isNotEmpty ? array[3] : '0';
    return model;
  }
}

class FollowInfoModel {
  num uid = 0;
  num followType = 1;
  String singleAmount = '';
  String amount = '';
  String stopDeficit = '';
  String stopProfit = '';
  String icon = '';
  String name = '';
  num isStopDeficit = 0;
  num isStopProfit = 0;
  num timeType = 0;
  List? symbolIconList;
  String smartAmount = '';
  String rate = '';
  int? levelType;

  String get singleAmountStr => '$singleAmount USDT';

  String get singleAmountRateStr => '$singleAmount ${LocaleKeys.follow77.tr}';

  String get amountStr => '$amount USDT';

  String get stopDeficitStr => num.parse(stopDeficit) > 0 ? stopDeficit : '--';

  String get stopProfitStr => num.parse(stopProfit) > 0 ? stopProfit : '--';

  num get isStopDeficitNum => num.parse(stopDeficit) > 0 ? 1 : 0;

  num get isStopProfitNum => num.parse(stopProfit) > 0 ? 1 : 0;

// Map<String, dynamic> toMap() {
//   return <String, dynamic>{
//     'timeType': timeType,
//     'followType': followType,
//     'singleAmountStr':singleAmountStr,

//     'amount': amount,
//     'stopDeficit': stopDeficit,
//     'stopProfit': stopProfit,
//     'isStopDeficit': num.parse(stopDeficit) > 0 ? 1 : 0,
//     'isStopProfit': num.parse(stopProfit) > 0 ? 1 : 0
//   };
}
