class CoinInfo {
  num? id;
  String? icon;
  String? logo;
  String? fullName;
  String? symbol;
  num? cmcRank;
  num? marketCap;
  num? circulatingSupply;
  num? totalSupply;
  num? maxSupply;
  num? publishPrice;
  DateTime? publishTime;
  num? publishTimestamp;
  num? hprice;
  DateTime? hpriceTime;
  num? lprice;
  DateTime? lpriceTime;
  String? officialUrl;
  String? blockchainUrl;
  String? blockchainBrowser;
  String? introduction;

  CoinInfo({
    this.id,
    this.icon,
    this.logo,
    this.fullName,
    this.symbol,
    this.cmcRank,
    this.marketCap,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.publishPrice,
    this.publishTime,
    this.publishTimestamp,
    this.hprice,
    this.hpriceTime,
    this.lprice,
    this.lpriceTime,
    this.officialUrl,
    this.blockchainUrl,
    this.blockchainBrowser,
    this.introduction,
  });

  factory CoinInfo.fromJson(Map<String, dynamic> json) => CoinInfo(
    id: json["id"],
    icon: json["icon"],
    logo: json["logo"],
    fullName: json["fullName"],
    symbol: json["symbol"],
    cmcRank: json["cmcRank"],
    marketCap: json["marketCap"],
    circulatingSupply: json["circulatingSupply"],
    totalSupply: json["totalSupply"],
    maxSupply: json["maxSupply"],
    publishPrice: json["publishPrice"],
    publishTime: json["publishTime"] == null ? null : DateTime.parse(json["publishTime"]),
    publishTimestamp: json["publishTimestamp"],
    hprice: json["hprice"],
    hpriceTime: json["hpriceTime"] == null ? null : DateTime.parse(json["hpriceTime"]),
    lprice: json["lprice"],
    lpriceTime: json["lpriceTime"] == null ? null : DateTime.parse(json["lpriceTime"]),
    officialUrl: json["officialUrl"],
    blockchainUrl: json["blockchainUrl"],
    blockchainBrowser: json["blockchainBrowser"],
    introduction: json["introduction"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "logo": logo,
    "fullName": fullName,
    "symbol": symbol,
    "cmcRank": cmcRank,
    "marketCap": marketCap,
    "circulatingSupply": circulatingSupply,
    "totalSupply": totalSupply,
    "maxSupply": maxSupply,
    "publishPrice": publishPrice,
    "publishTime": publishTime?.toIso8601String(),
    "publishTimestamp": publishTimestamp,
    "hprice": hprice,
    "hpriceTime": hpriceTime?.toIso8601String(),
    "lprice": lprice,
    "lpriceTime": lpriceTime?.toIso8601String(),
    "officialUrl": officialUrl,
    "blockchainUrl": blockchainUrl,
    "blockchainBrowser": blockchainBrowser,
    "introduction": introduction,
  };
}
