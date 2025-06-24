class StockInfo {
  num? amount;
  num? amplitude;
  num? biddingAmount;
  num? biddingChg;
  num? biddingGain;
  num? biddingHigh;
  num? biddingLow;
  num? biddingPrice;
  num? biddingTime;
  num? biddingVolume;
  num? chg;
  num? close;
  String? currency;
  num? dividend;
  num? dividendRate;
  num? gain;
  num? high;
  num? high52W;
  String? industryPlate;
  num? latestPrice;
  num? latestTime;
  num? lotSize;
  num? low;
  num? low52W;
  String? market;
  num? marketValue;
  String? name;
  num? open;
  num? pb;
  num? peLyr;
  num? peStatic;
  num? peTtm;
  num? precision;
  num? securityStatus;
  String? securityType;
  String? symbol;
  num? totalShares;
  num? turnover;
  num? volume;
  String? introduction;

  StockInfo({
    this.amount,
    this.amplitude,
    this.biddingAmount,
    this.biddingChg,
    this.biddingGain,
    this.biddingHigh,
    this.biddingLow,
    this.biddingPrice,
    this.biddingTime,
    this.biddingVolume,
    this.chg,
    this.close,
    this.currency,
    this.dividend,
    this.dividendRate,
    this.gain,
    this.high,
    this.high52W,
    this.industryPlate,
    this.latestPrice,
    this.latestTime,
    this.lotSize,
    this.low,
    this.low52W,
    this.market,
    this.marketValue,
    this.name,
    this.open,
    this.pb,
    this.peLyr,
    this.peStatic,
    this.peTtm,
    this.precision,
    this.securityStatus,
    this.securityType,
    this.symbol,
    this.totalShares,
    this.turnover,
    this.volume,
    this.introduction,
  });

  factory StockInfo.fromJson(Map<String, dynamic> json) => StockInfo(
    amount: json["amount"],
    amplitude: json["amplitude"],
    biddingAmount: json["biddingAmount"],
    biddingChg: json["biddingChg"],
    biddingGain: json["biddingGain"],
    biddingHigh: json["biddingHigh"],
    biddingLow: json["biddingLow"],
    biddingPrice: json["biddingPrice"],
    biddingTime: json["biddingTime"],
    biddingVolume: json["biddingVolume"],
    chg: json["chg"],
    close: json["close"],
    currency: json["currency"],
    dividend: json["dividend"],
    dividendRate: json["dividendRate"],
    gain: json["gain"],
    high: json["high"],
    high52W: json["high52W"],
    industryPlate: json["industryPlate"],
    latestPrice: json["latestPrice"],
    latestTime: json["latestTime"],
    lotSize: json["lotSize"],
    low: json["low"],
    low52W: json["low52W"],
    market: json["market"],
    marketValue: json["marketValue"],
    name: json["name"],
    open: json["open"],
    pb: json["pb"],
    peLyr: json["peLyr"],
    peStatic: json["peStatic"],
    peTtm: json["peTtm"],
    precision: json["precision"],
    securityStatus: json["securityStatus"],
    securityType: json["securityType"],
    symbol: json["symbol"],
    totalShares: json["totalShares"],
    turnover: json["turnover"],
    volume: json["volume"],
    introduction: json["introduction"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "amplitude": amplitude,
    "biddingAmount": biddingAmount,
    "biddingChg": biddingChg,
    "biddingGain": biddingGain,
    "biddingHigh": biddingHigh,
    "biddingLow": biddingLow,
    "biddingPrice": biddingPrice,
    "biddingTime": biddingTime,
    "biddingVolume": biddingVolume,
    "chg": chg,
    "close": close,
    "currency": currency,
    "dividend": dividend,
    "dividendRate": dividendRate,
    "gain": gain,
    "high": high,
    "high52W": high52W,
    "industryPlate": industryPlate,
    "latestPrice": latestPrice,
    "latestTime": latestTime,
    "lotSize": lotSize,
    "low": low,
    "low52W": low52W,
    "market": market,
    "marketValue": marketValue,
    "name": name,
    "open": open,
    "pb": pb,
    "peLyr": peLyr,
    "peStatic": peStatic,
    "peTtm": peTtm,
    "precision": precision,
    "securityStatus": securityStatus,
    "securityType": securityType,
    "symbol": symbol,
    "totalShares": totalShares,
    "turnover": turnover,
    "volume": volume,
    "introduction": introduction,
  };
}
