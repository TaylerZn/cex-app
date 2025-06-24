import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

class DepthMap {
  List<List<num>> buys;
  num middle;
  List<List<num>> asks;

  DepthMap({
    required this.buys,
    required this.middle,
    required this.asks,
  });

  factory DepthMap.fromJson(Map<String, dynamic> json) => DepthMap(
        buys: List<List<num>>.from(json["buys"]
            .map((x) => List<num>.from(x.map((x) => x.toString().toNum())))),
        middle: json["middle"].toString().toNum(),
        asks: List<List<num>>.from(json["asks"]
            .map((x) => List<num>.from(x.map((x) => x.toString().toNum())))),
      );

  Map<String, dynamic> toJson() => {
        "buys": List<dynamic>.from(
            buys.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "middle": middle,
        "asks": List<dynamic>.from(
            asks.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
