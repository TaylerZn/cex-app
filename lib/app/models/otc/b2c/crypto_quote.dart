// class CryptoQuote {
//   String? baseCurrencyCode;
//   double? baseCurrencyAmount;
//   String? quoteCurrencyCode;
//   double? quoteCurrencyAmount;
//   double? quoteCurrencyPrice;

//   CryptoQuote({
//     this.baseCurrencyCode,
//     this.baseCurrencyAmount,
//     this.quoteCurrencyCode,
//     this.quoteCurrencyAmount,
//     this.quoteCurrencyPrice,
//   });

//   factory CryptoQuote.fromJson(Map<String, dynamic> json) => CryptoQuote(
//         baseCurrencyCode: json["baseCurrencyCode"],
//         baseCurrencyAmount: json["baseCurrencyAmount"]?.toDouble(),
//         quoteCurrencyCode: json["quoteCurrencyCode"],
//         quoteCurrencyAmount: json["quoteCurrencyAmount"]?.toDouble(),
//         quoteCurrencyPrice: json["quoteCurrencyPrice"]?.toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "baseCurrencyCode": baseCurrencyCode,
//         "baseCurrencyAmount": baseCurrencyAmount,
//         "quoteCurrencyCode": quoteCurrencyCode,
//         "quoteCurrencyAmount": quoteCurrencyAmount,
//         "quoteCurrencyPrice": quoteCurrencyPrice,
//       };
// }

class B2CCryptoQuote {
  String? cryptoPrice;
  String? side;
  String? fiatAmount;
  String? cryptoQuantity;
  String? rampFee;
  String? networkFee;
  String? fiat;
  String? crypto;
  String? cryptoNetworkFee;

  num quoteCurrencyPrice = 1;

  B2CCryptoQuote(
      {this.cryptoPrice,
      this.side,
      this.fiatAmount,
      this.cryptoQuantity,
      this.rampFee,
      this.networkFee,
      this.fiat,
      this.crypto,
      this.cryptoNetworkFee});

  B2CCryptoQuote.fromJson(Map<String, dynamic> json) {
    cryptoPrice = json['cryptoPrice'];
    side = json['side'];
    fiatAmount = json['fiatAmount'];
    cryptoQuantity = json['cryptoQuantity'];
    rampFee = json['rampFee'];
    networkFee = json['networkFee'];
    fiat = json['fiat'];
    crypto = json['crypto'];
    cryptoNetworkFee = json['cryptoNetworkFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cryptoPrice'] = this.cryptoPrice;
    data['side'] = this.side;
    data['fiatAmount'] = this.fiatAmount;
    data['cryptoQuantity'] = this.cryptoQuantity;
    data['rampFee'] = this.rampFee;
    data['networkFee'] = this.networkFee;
    data['fiat'] = this.fiat;
    data['crypto'] = this.crypto;
    data['cryptoNetworkFee'] = this.cryptoNetworkFee;
    return data;
  }

  num get rate => num.parse(fiatAmount ?? '1') / num.parse(cryptoQuantity ?? '1');
}
