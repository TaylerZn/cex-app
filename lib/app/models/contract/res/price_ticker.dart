import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

class PriceTicker {
  num esPrice;
  num amount;
  num close;
  num high;
  num low;
  num open;
  num rose;
  num vol;

  PriceTicker({
    required this.esPrice,
    required this.amount,
    required this.close,
    required this.high,
    required this.low,
    required this.open,
    required this.rose,
    required this.vol,
  });

  factory PriceTicker.fromJson(Map<String, dynamic> json) => PriceTicker(
        esPrice: json["es_price"].toString().toNum(),
        amount: json["amount"].toString().toNum(),
        close: json["close"].toString().toNum(),
        high: json["high"].toString().toNum(),
        low: json["low"].toString().toNum(),
        open: json["open"].toString().toNum(),
        rose: json["rose"].toString().toNum(),
        vol: json["vol"].toString().toNum(),
      );

  Map<String, dynamic> toJson() => {
        "es_price": esPrice,
        "amount": amount,
        "close": close,
        "high": high,
        "low": low,
        "open": open,
        "rose": rose,
        "vol": vol,
      };
}
