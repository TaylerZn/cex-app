import 'dart:convert';

class DisplayLinksModel {
  String? accountProtocol;
  String? onlineServiceProtocal;
  String? followProtocol;
  String? contractUsageAgreement;
  String? futuresUseAgreement;
  String? riskDisclosure;
  String? disclaimer;
  AbountUs? abountUs;
  HelpCenter? helpCenter;
  String? inviteRules;
  String? accountDelete;
  String? communityAgreement;
  LinksShareModel? share;
  String? couponRules;
  String? followDealPriceDescription;
  String? proxyRules;
  String? proofOfReserve;

  DisplayLinksModel(
      {this.accountProtocol,
      this.onlineServiceProtocal,
      this.followProtocol,
      this.contractUsageAgreement,
      this.futuresUseAgreement,
      this.riskDisclosure,
      this.disclaimer,
      this.abountUs,
      this.helpCenter,
      this.inviteRules,
      this.accountDelete,
      this.communityAgreement,
      this.share,
      this.couponRules,
      this.followDealPriceDescription,
      this.proxyRules,
      this.proofOfReserve});

  factory DisplayLinksModel.fromRawJson(String str) => DisplayLinksModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DisplayLinksModel.fromJson(Map<String, dynamic> json) => DisplayLinksModel(
        accountProtocol: json["accountProtocol"],
        onlineServiceProtocal: json["onlineServiceProtocal"],
        followProtocol: json["followProtocol"],
        contractUsageAgreement: json["contractUsageAgreement"],
        futuresUseAgreement: json["futuresUseAgreement"],
        riskDisclosure: json["riskDisclosure"],
        disclaimer: json["disclaimer"],
        abountUs: json["abountUs"] == null ? null : AbountUs.fromJson(json["abountUs"]),
        helpCenter: json["helpCenter"] == null ? null : HelpCenter.fromJson(json["helpCenter"]),
        inviteRules: json["inviteRules"],
        accountDelete: json["accountDelete"],
        communityAgreement: json["communityAgreement"],
        share: json["share"] == null ? null : LinksShareModel.fromJson(json["share"]),
        couponRules: json["couponRules"],
        followDealPriceDescription: json["followDealPriceDescription"],
        proxyRules: json["proxyRules"],
        proofOfReserve: json["proofOfReserve"],
      );

  Map<String, dynamic> toJson() => {
        "accountProtocol": accountProtocol,
        "onlineServiceProtocal": onlineServiceProtocal,
        "followProtocol": followProtocol,
        "contractUsageAgreement": contractUsageAgreement,
        "futuresUseAgreement": futuresUseAgreement,
        "riskDisclosure": riskDisclosure,
        "disclaimer": disclaimer,
        "abountUs": abountUs?.toJson(),
        "helpCenter": helpCenter?.toJson(),
        "inviteRules": inviteRules,
        "accountDelete": accountDelete,
        "communityAgreement": communityAgreement,
        "share": share?.toJson(),
        "couponRules": couponRules,
        "followDealPriceDescription": followDealPriceDescription,
        "proxyRules": proxyRules,
        "proofOfReserve": proofOfReserve,
      };
}

class AbountUs {
  String? twitter;
  String? discord;
  String? telegram;
  String? email;
  String? userProtocal;
  String? riskProtocal;
  String? privacyProtocal;
  String? platformIntroduce;
  String? coinApplication;
  String? usLicense;
  String? businessCooperation;

  AbountUs({
    this.twitter,
    this.discord,
    this.telegram,
    this.email,
    this.userProtocal,
    this.riskProtocal,
    this.privacyProtocal,
    this.platformIntroduce,
    this.coinApplication,
    this.usLicense,
    this.businessCooperation,
  });

  factory AbountUs.fromRawJson(String str) => AbountUs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AbountUs.fromJson(Map<String, dynamic> json) => AbountUs(
        twitter: json["twitter"],
        discord: json["discord"],
        telegram: json["telegram"],
        email: json["email"],
        userProtocal: json["userProtocal"],
        riskProtocal: json["riskProtocal"],
        privacyProtocal: json["privacyProtocal"],
        platformIntroduce: json["platformIntroduce"],
        coinApplication: json["coinApplication"],
        usLicense: json["usLicense"],
        businessCooperation: json["businessCooperation"],
      );

  Map<String, dynamic> toJson() => {
        "twitter": twitter,
        "discord": discord,
        "telegram": telegram,
        "email": email,
        "userProtocal": userProtocal,
        "riskProtocal": riskProtocal,
        "privacyProtocal": privacyProtocal,
        "platformIntroduce": platformIntroduce,
        "coinApplication": coinApplication,
        "usLicense": usLicense,
        "businessCooperation": businessCooperation,
      };
}

class HelpCenter {
  String? commonProblem;
  String? howToCopyTrade;

  HelpCenter({this.commonProblem, this.howToCopyTrade});

  factory HelpCenter.fromRawJson(String str) => HelpCenter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HelpCenter.fromJson(Map<String, dynamic> json) =>
      HelpCenter(commonProblem: json["commonProblem"], howToCopyTrade: json["howToCopyTrade"]);

  Map<String, dynamic> toJson() => {"commonProblem": commonProblem, "howToCopyTrade": howToCopyTrade};
}

class LinksShareModel {
  String? topicUrl;
  String? followUrl;
  String? followHistoryUrl;
  String? inviteUserUrl;
  String? futuresUrl;
  String? downloadUrl;

  LinksShareModel({
    this.topicUrl,
    this.followUrl,
    this.followHistoryUrl,
    this.inviteUserUrl,
    this.futuresUrl,
    this.downloadUrl,
  });

  factory LinksShareModel.fromRawJson(String str) => LinksShareModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LinksShareModel.fromJson(Map<String, dynamic> json) => LinksShareModel(
        topicUrl: json["topicUrl"],
        followUrl: json["followUrl"],
        followHistoryUrl: json["followHistoryUrl"],
        inviteUserUrl: json["inviteUserUrl"],
        futuresUrl: json["futuresUrl"],
        downloadUrl: json["downloadUrl"],
      );

  Map<String, dynamic> toJson() => {
        "topicUrl": topicUrl,
        "followUrl": followUrl,
        "followHistoryUrl": followHistoryUrl,
        "inviteUserUrl": inviteUserUrl,
        "futuresUrl": futuresUrl,
        "downloadUrl": downloadUrl,
      };
}
