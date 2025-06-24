
// To parse this JSON data, do
//
//     final rateRes = rateResFromJson(jsonString);

import 'dart:convert';

RateRes rateResFromJson(String str) => RateRes.fromJson(json.decode(str));

String rateResToJson(RateRes data) => json.encode(data.toJson());

class RateRes {
    CountryRate rate;

    RateRes({
        required this.rate,
    });

    factory RateRes.fromJson(Map<String, dynamic> json) => RateRes(
        rate: CountryRate.fromJson(json["rate"]),
    );

    Map<String, dynamic> toJson() => {
        "rate": rate.toJson(),
    };
}

class CountryRate {
    Rate koKr;
    Rate enUs;
    Rate zhCn;
    Rate jaJp;

    CountryRate({
        required this.koKr,
        required this.enUs,
        required this.zhCn,
        required this.jaJp,
    });

    factory CountryRate.fromJson(Map<String, dynamic> json) => CountryRate(
        koKr: Rate.fromJson(json["ko_KR"]),
        enUs: Rate.fromJson(json["en_US"]),
        zhCn: Rate.fromJson(json["zh_CN"]),
        jaJp: Rate.fromJson(json["ja_JP"]),
    );

    Map<String, dynamic> toJson() => {
        "ko_KR": koKr.toJson(),
        "en_US": enUs.toJson(),
        "zh_CN": zhCn.toJson(),
        "ja_JP": jaJp.toJson(),
    };
}

class Rate {
    double apo;
    dynamic coinPrecision;
    double bch;
    dynamic usd;
    String langCoin;
    double eos;
    double usdt;
    double btc;
    double uni;
    String langLogo;
    dynamic coinFiatPrecision;
    double etc;
    double brd;
    double eth;
    double link;
    double ltc;
    double trx;
    String? krw;
    String? cny;
    num? ec;
    String? jpy;

    Rate({
        required this.apo,
        required this.coinPrecision,
        required this.bch,
        this.usd,
        required this.langCoin,
        required this.eos,
        required this.usdt,
        required this.btc,
        required this.uni,
        required this.langLogo,
        required this.coinFiatPrecision,
        required this.etc,
        required this.brd,
        required this.eth,
        required this.link,
        required this.ltc,
        required this.trx,
        this.krw,
        this.cny,
        this.ec,
        this.jpy,
    });

    factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        apo: json["APO"]?.toDouble(),
        coinPrecision: json["coin_precision"],
        bch: json["BCH"]?.toDouble(),
        usd: json["USD"],
        langCoin: json["lang_coin"],
        eos: json["EOS"]?.toDouble(),
        usdt: json["USDT"]?.toDouble(),
        btc: json["BTC"]?.toDouble(),
        uni: json["UNI"]?.toDouble(),
        langLogo: json["lang_logo"],
        coinFiatPrecision: json["coin_fiat_precision"],
        etc: json["ETC"]?.toDouble(),
        brd: json["BRD"]?.toDouble(),
        eth: json["ETH"]?.toDouble(),
        link: json["LINK"]?.toDouble(),
        ltc: json["LTC"]?.toDouble(),
        trx: json["TRX"]?.toDouble(),
        krw: json["KRW"],
        cny: json["CNY"],
        ec: json["EC"],
        jpy: json["JPY"],
    );

    Map<String, dynamic> toJson() => {
        "APO": apo,
        "coin_precision": coinPrecision,
        "BCH": bch,
        "USD": usd,
        "lang_coin": langCoin,
        "EOS": eos,
        "USDT": usdt,
        "BTC": btc,
        "UNI": uni,
        "lang_logo": langLogo,
        "coin_fiat_precision": coinFiatPrecision,
        "ETC": etc,
        "BRD": brd,
        "ETH": eth,
        "LINK": link,
        "LTC": ltc,
        "TRX": trx,
        "KRW": krw,
        "CNY": cny,
        "EC": ec,
        "JPY": jpy,
    };
}
