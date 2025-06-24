import 'dart:convert';

import 'package:azlistview/azlistview.dart';

class CountryListModel {
  List<CountryList?>? countryList;

  CountryListModel({
    this.countryList,
  });

  factory CountryListModel.fromRawJson(String str) =>
      CountryListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryListModel.fromJson(Map<String, dynamic> json) =>
      CountryListModel(
        countryList: json["countryList"] == null
            ? []
            : List<CountryList>.from(
                json["countryList"]!.map((x) => CountryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countryList": countryList == null
            ? []
            : List<dynamic>.from(countryList!.map((x) => x?.toJson())),
      };
}

class CountryList extends ISuspensionBean {
  String? enName;
  String? cnName;
  String? dialingCode;
  String? numberCode;
  String? showName;
  String? tagIndex;

  CountryList(
      {this.enName,
      this.cnName,
      this.dialingCode,
      this.numberCode,
      this.showName,
      this.tagIndex});

  factory CountryList.fromRawJson(String str) =>
      CountryList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
        enName: json["enName"],
        cnName: json["cnName"],
        dialingCode: json["dialingCode"],
        numberCode: json["numberCode"],
        showName: json["showName"],
        tagIndex: json["tagIndex"],
      );

  Map<String, dynamic> toJson() => {
        "enName": enName,
        "cnName": cnName,
        "dialingCode": dialingCode,
        "numberCode": numberCode,
        "showName": showName,
        "tagIndex": tagIndex,
      };

  @override
  String getSuspensionTag() => tagIndex ?? '';
}
