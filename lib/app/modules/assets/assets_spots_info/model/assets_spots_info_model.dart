// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AssetsSpotsDetailModel {
  int pageSize = 50;
  int page = 0;
  bool haveMore = false;
  List<AssetsSpotsHistoryModel>? data;
  bool isInitial = true;
}

class AssetsSpotsHistoryModel {
  String type = '';
  String name = '';
  String value = '';
  String time = '';
  AssetsSpotsHistoryModel({
    required this.type,
    required this.name,
    required this.value,
    required this.time,
  });

  factory AssetsSpotsHistoryModel.fromMap(Map<String, dynamic> map) {
    return AssetsSpotsHistoryModel(
      type: map['type'],
      name: map['name'],
      value: map['value'],
      time: map['time'],
    );
  }
}
