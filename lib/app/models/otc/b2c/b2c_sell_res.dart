class B2CSellRes {
  Params? params;
  String? signStr;

  B2CSellRes({
    this.params,
    this.signStr,
  });

  factory B2CSellRes.fromJson(Map<String, dynamic> json) => B2CSellRes(
        params: json["params"] == null ? null : Params.fromJson(json["params"]),
        signStr: json["signStr"],
      );

  Map<String, dynamic> toJson() => {
        "params": params?.toJson(),
        "signStr": signStr,
      };
}

class Params {
  String? apikey;
  String? currencyCode;
  String? walletAddress;
  String? baseCurrencyCode;
  String? baseCurrencyAmount;
  bool? lockAmount;
  String? email;
  String? externalTransactionId;
  String? externalCustomerId;

  Params({
    this.apikey,
    this.currencyCode,
    this.walletAddress,
    this.baseCurrencyCode,
    this.baseCurrencyAmount,
    this.lockAmount,
    this.email,
    this.externalTransactionId,
    this.externalCustomerId,
  });

  factory Params.fromJson(Map<String, dynamic> json) => Params(
        apikey: json["apikey"],
        currencyCode: json["currencyCode"],
        walletAddress: json["walletAddress"],
        baseCurrencyCode: json["baseCurrencyCode"],
        baseCurrencyAmount: json["baseCurrencyAmount"],
        lockAmount: json["lockAmount"],
        email: json["email"],
        externalTransactionId: json["externalTransactionId"],
        externalCustomerId: json["externalCustomerId"],
      );

  Map<String, dynamic> toJson() => {
        "apikey": apikey,
        "currencyCode": currencyCode,
        "walletAddress": walletAddress,
        "baseCurrencyCode": baseCurrencyCode,
        "baseCurrencyAmount": baseCurrencyAmount,
        "lockAmount": lockAmount,
        "email": email,
        "externalTransactionId": externalTransactionId,
        "externalCustomerId": externalCustomerId,
      };
}
