import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

class TradeDetailInfo {
  num? high;
  num? low;
  String? rose;
  String? scale;

  TradeDetailInfo({
    required this.high,
    required this.low,
    required this.rose,
    required this.scale,
  });

  factory TradeDetailInfo.fromJson(Map<String, dynamic> json) {
    return TradeDetailInfo(
      high: json['high'].toString().toDouble(),
      low: json['low'].toString().toDouble(),
      rose: json['rose'],
      scale: json['scale'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'high': high,
      'low': low,
      'rose': rose,
      'scale': scale,
    };
  }
}
