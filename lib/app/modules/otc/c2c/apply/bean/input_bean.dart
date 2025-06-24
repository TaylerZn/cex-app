// To parse this JSON data, do
//
//     final inputBean = inputBeanFromJson(jsonString);

import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:get/utils.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/widget/content_option_widget.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../../../utils/utilities/regexp_util.dart';

InputBean inputBeanFromJson(String str) => InputBean.fromJson(json.decode(str));

String inputBeanToJson(InputBean data) => json.encode(data.toJson());

class InputBean {
  List<Datum>? data;

  InputBean({
    this.data,
  });

  factory InputBean.fromJson(Map<String, dynamic> json) => InputBean(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? question;
  bool? mandatory;
  int? type;
  int? format;
  String? hintText;
  String? value;
  String? key;
  List<String?>? optionList;
  bool? showError;
  bool? match;
  int? regex;
  int? keyboardType;
  String? errorTxt;
  List<AssetEntity?>? images;

  Datum({
    this.question,
    this.mandatory,
    this.type,
    this.format,
    this.hintText,
    this.value,
    this.key,
    this.regex,
    this.errorTxt,
    this.keyboardType,
    this.optionList,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        question: json["question"],
        mandatory: json["mandatory"],
        type: json["type"],
        format: json["format"],
        hintText: json["hintText"],
        regex: json['regex'],
        keyboardType: json['keyboardType'],
        errorTxt: json['errorTxt'],
        value: ObjectUtil.isEmpty(json["value"]) ? '' : '${json['value']}',
        key: json["key"],
        optionList: json["optionList"] == null ? [] : List<String?>.from(json["optionList"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "mandatory": mandatory,
        "type": type,
        "format": format,
        "hintText": hintText,
        "value": value,
        "key": key,
        "errorTxt": errorTxt,
        "keyboardType": keyboardType,
        'regex': regex,
        "optionList": optionList == null ? [] : List<dynamic>.from(optionList!.map((x) => x)),
      };

  ContentFillType get fillType {
    switch (type) {
      case 0:
        return ContentFillType.dropdown;
      case 1:
        return ContentFillType.input;
      case 2:
        return ContentFillType.image;
      case 3:
        return ContentFillType.dropdown;
      default:
        return ContentFillType.dropdown;
    }
  }

  bool empty() {
    if (fillType == ContentFillType.image && ObjectUtil.isEmpty(images)) {
      // element.showError = true;
      // completed = false;
      return true;
    }
    if (fillType != ContentFillType.image && ObjectUtil.isEmpty(value)) {
      // element.showError = true;
      // completed = false;
      return true;
    }
    return false;
  }

  bool matchValue() {
    if (ObjectUtil.isEmpty(value)) {
      return true;
    }
    switch (regex) {
      case 0:
        return UtilRegExp.phone(value!);
      case 1:
        return UtilRegExp.email(value!);
    }
    return true;
  }
}

class OptionListClass {
  String? fieldKey;
  String? fieldValue;

  OptionListClass({
    this.fieldKey,
    this.fieldValue,
  });

  factory OptionListClass.fromJson(Map<String, dynamic> json) => OptionListClass(
        fieldKey: json["fieldKey"],
        fieldValue: json["fieldValue"],
      );

  Map<String, dynamic> toJson() => {
        "fieldKey": fieldKey,
        "fieldValue": fieldValue,
      };
}
