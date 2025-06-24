// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';

class MyFollowIncomeInfo {
  num incomeRate = 0;
  num followAmount = 0;
  num incomeAmount = 0;
  MyFollowIncomeInfo({
    this.incomeRate = 0,
    this.followAmount = 0,
    this.incomeAmount = 0,
  });

  MyFollowIncomeInfo.fromJson(Map<String, dynamic> json) {
    incomeRate = json['income_rate'] ?? 0;
    followAmount = json['follow_amount'] ?? 0;
    incomeAmount = json['income_amount'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['income_rate'] = incomeRate;
    data['follow_amount'] = followAmount;
    data['income_amount'] = incomeAmount;
    return data;
  }

  Color get rateStrColor => incomeRate >= 0 ? AppColor.upColor : AppColor.downColor;
}
