// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AssetsFundsInfoDetailModel {
  int pageSize = 50;
  int page = 0;
  bool haveMore = false;
  List<AssetsFundsInfoModel>? data;
}

class AssetsFundsInfoModel {
  String type = '';
  String name = '';
  String value = '';
  String time = '';
  AssetsFundsInfoModel({
    required this.type,
    required this.name,
    required this.value,
    required this.time,
  });

  factory AssetsFundsInfoModel.fromMap(Map<String, dynamic> map) {
    return AssetsFundsInfoModel(
      type: map['type'],
      name: map['name'],
      value: map['value'],
      time: map['time'],
    );
  }
}
