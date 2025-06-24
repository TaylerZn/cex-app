import 'dart:convert';

class User {
  String? token;
  UserInfo? info;
  int? openContract;
  UserAgentInfo? agentInfo;

  User({
    this.token,
    this.info,
    this.openContract,
    this.agentInfo,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        info: json["info"] == null ? null : UserInfo.fromJson(json["info"]),
        openContract: json["openContract"],
        agentInfo: json["agentInfo"] == null
            ? null
            : UserAgentInfo.fromJson(json["agentInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "info": info,
        "openContract": openContract,
        "agentInfo": agentInfo,
      };
}

class UserInfo {
  int? googleStatus;
  String? isFancingOpen;
  List<dynamic>? coMyMarket;
  String? isDestroyOpen;
  String? mobileNumber;
  int? otcSaveAdOnOff;
  String? brokerUrl;
  String? feeCoinRate;
  String? isWalletOpen;
  String? isBrokerOpen;
  UserCompanyInfo? userCompanyInfo;
  String? feeCoinOpen;
  String? lastLoginIp;
  int? accountStatus;
  int? isOpenMobileCheck;
  String? phoneAuthBirthday;
  String? countryCode;
  String? inviteUrl;
  String? exchangeCoinUrl;
  String? exportExcelAuth;
  int? id;
  String? email;
  OtcCompanyInfo? otcCompanyInfo;
  String? isKrwPhoneAuth;
  String? phoneAuthTel;
  String? nickName;
  int? isCapitalPwordSet;
  List<dynamic>? myMarket;
  int? agentStatus;
  int? useFeeCoinOpen;
  String? lastLoginTime;
  String? realName;
  String? feeCoin;
  String? walletBindStatus;
  String? userAccount;
  String? inviteCode;
  String? roleName;
  String? phoneAuthName;
  String? inviteQeCode;
  String? notPassReason;

  /// 认证等级:认证等级：0、未进行认证，1、实名认证，2、身份证（或护照）照片认证，3、视频认证；认证等级为通过状态，例如C2则是身份证照片认证通过
  int? authLevel;

  ///0、未审核，1、通过，2、未通过 3未认证
  int? authStatus;
  String? isHoldingOpen;
  String? profilePictureUrl;
  String? signatureInfo;
  bool? isKol;
  String? logoInfo;
  int? levelType;

  UserInfo({
    this.googleStatus,
    this.isFancingOpen,
    this.coMyMarket,
    this.isDestroyOpen,
    this.mobileNumber,
    this.otcSaveAdOnOff,
    this.brokerUrl,
    this.feeCoinRate,
    this.isWalletOpen,
    this.isBrokerOpen,
    this.userCompanyInfo,
    this.feeCoinOpen,
    this.lastLoginIp,
    this.accountStatus,
    this.isOpenMobileCheck,
    this.phoneAuthBirthday,
    this.countryCode,
    this.inviteUrl,
    this.exchangeCoinUrl,
    this.exportExcelAuth,
    this.id,
    this.email,
    this.otcCompanyInfo,
    this.isKrwPhoneAuth,
    this.phoneAuthTel,
    this.nickName,
    this.isCapitalPwordSet,
    this.myMarket,
    this.agentStatus,
    this.useFeeCoinOpen,
    this.lastLoginTime,
    this.realName,
    this.feeCoin,
    this.walletBindStatus,
    this.userAccount,
    this.inviteCode,
    this.roleName,
    this.phoneAuthName,
    this.inviteQeCode,
    this.notPassReason,
    this.authLevel,
    this.authStatus,
    this.isHoldingOpen,
    this.profilePictureUrl,
    this.signatureInfo,
    this.isKol,
    this.logoInfo,
    this.levelType,
  });

  factory UserInfo.fromRawJson(String str) =>
      UserInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        googleStatus: json["googleStatus"],
        isFancingOpen: json["is_fancing_open"],
        coMyMarket: json["coMyMarket"] == null
            ? []
            : List<dynamic>.from(json["coMyMarket"]!.map((x) => x)),
        isDestroyOpen: json["is_destroy_open"],
        mobileNumber: json["mobileNumber"],
        otcSaveAdOnOff: json["otc_save_ad_on_off"],
        brokerUrl: json["broker_url"],
        feeCoinRate: json["feeCoinRate"],
        isWalletOpen: json["is_wallet_open"],
        isBrokerOpen: json["is_broker_open"],
        userCompanyInfo: json["userCompanyInfo"] == null
            ? null
            : UserCompanyInfo.fromJson(json["userCompanyInfo"]),
        feeCoinOpen: json["fee_coin_open"],
        lastLoginIp: json["lastLoginIp"],
        accountStatus: json["accountStatus"],
        isOpenMobileCheck: json["isOpenMobileCheck"],
        phoneAuthBirthday: json["phone_auth_birthday"],
        countryCode: json["countryCode"],
        inviteUrl: json["inviteUrl"],
        exchangeCoinUrl: json["exchange_coin_url"],
        exportExcelAuth: json["exportExcelAuth"],
        id: json["id"],
        email: json["email"],
        otcCompanyInfo: json["otcCompanyInfo"] == null
            ? null
            : OtcCompanyInfo.fromJson(json["otcCompanyInfo"]),
        isKrwPhoneAuth: json["is_krw_phone_auth"],
        phoneAuthTel: json["phone_auth_tel"],
        nickName: json["nickName"],
        isCapitalPwordSet: json["isCapitalPwordSet"],
        myMarket: json["myMarket"] == null
            ? []
            : List<dynamic>.from(json["myMarket"]!.map((x) => x)),
        agentStatus: json["agentStatus"],
        useFeeCoinOpen: json["useFeeCoinOpen"],
        lastLoginTime: json["lastLoginTime"],
        realName: json["realName"],
        feeCoin: json["feeCoin"],
        walletBindStatus: json["wallet_bind_status"],
        userAccount: json["userAccount"],
        inviteCode: json["inviteCode"],
        roleName: json["roleName"],
        phoneAuthName: json["phone_auth_name"],
        inviteQeCode: json["inviteQECode"],
        notPassReason: json["notPassReason"],
        authLevel: json["authLevel"],
        authStatus: json["authStatus"],
        isHoldingOpen: json["is_holding_open"],
        profilePictureUrl: json["profilePictureUrl"],
        signatureInfo: json["signatureInfo"],
        isKol: json["isKol"],
        logoInfo: json["logoInfo"],
        levelType: json["levelType"],
      );

  Map<String, dynamic> toJson() => {
        "googleStatus": googleStatus,
        "is_fancing_open": isFancingOpen,
        "coMyMarket": coMyMarket == null
            ? []
            : List<dynamic>.from(coMyMarket!.map((x) => x)),
        "is_destroy_open": isDestroyOpen,
        "mobileNumber": mobileNumber,
        "otc_save_ad_on_off": otcSaveAdOnOff,
        "broker_url": brokerUrl,
        "feeCoinRate": feeCoinRate,
        "is_wallet_open": isWalletOpen,
        "is_broker_open": isBrokerOpen,
        "userCompanyInfo": userCompanyInfo?.toJson(),
        "fee_coin_open": feeCoinOpen,
        "lastLoginIp": lastLoginIp,
        "accountStatus": accountStatus,
        "isOpenMobileCheck": isOpenMobileCheck,
        "phone_auth_birthday": phoneAuthBirthday,
        "countryCode": countryCode,
        "inviteUrl": inviteUrl,
        "exchange_coin_url": exchangeCoinUrl,
        "exportExcelAuth": exportExcelAuth,
        "id": id,
        "email": email,
        "otcCompanyInfo": otcCompanyInfo?.toJson(),
        "is_krw_phone_auth": isKrwPhoneAuth,
        "phone_auth_tel": phoneAuthTel,
        "nickName": nickName,
        "isCapitalPwordSet": isCapitalPwordSet,
        "myMarket":
            myMarket == null ? [] : List<dynamic>.from(myMarket!.map((x) => x)),
        "agentStatus": agentStatus,
        "useFeeCoinOpen": useFeeCoinOpen,
        "lastLoginTime": lastLoginTime,
        "realName": realName,
        "feeCoin": feeCoin,
        "wallet_bind_status": walletBindStatus,
        "userAccount": userAccount,
        "inviteCode": inviteCode,
        "roleName": roleName,
        "phone_auth_name": phoneAuthName,
        "inviteQECode": inviteQeCode,
        "notPassReason": notPassReason,
        "authLevel": authLevel,
        "authStatus": authStatus,
        "is_holding_open": isHoldingOpen,
        "profilePictureUrl": profilePictureUrl,
        "signatureInfo": signatureInfo,
        "isKol": isKol,
        "logoInfo": logoInfo,
        "levelType": levelType,
      };
}

class UserAgentInfo {
  String? roleName;
  num? roleType;
  num? scaleReturn; //返佣比例
  String? amountTotal; // 返佣总收益
  String? amountYesterday; // 昨日返佣
  num? userCount; //直邀人数
  num? coAgentStatus;
  String? coin;
  num? totalNumber; // 团队人数 (经纪人才有)
  String? agentApplyFormUrl; //经纪人申请表单url，不是经纪人才有
  // num? amountTotal; // 返佣总收益
  // String? amountYesterday; // 昨日返佣
  // String? totalNumber; // 团队人数 (经纪人才有)
  // String? agent_apply_form_url; //经纪人申请表单url，不是经纪人才有
  int? agentStatus; // 是否为经纪人:0=非经纪人；1=经纪人
  String? inviteUrl; // 邀请链接
  String? inviteCode; // 邀请码
  String? inviteQECode; //邀请二维码
  String? agentSiteUrl; //经纪人后台地址，不是经纪人才成为经纪人后才有

  UserAgentInfo({
    this.roleName,
    this.roleType,
    this.scaleReturn,
    this.amountTotal,
    this.amountYesterday,
    this.userCount,
    this.coAgentStatus,
    this.coin,
    this.totalNumber,
    this.agentApplyFormUrl, //经纪人申请表单url，不是经纪人才有
    this.agentStatus, // 是否为经纪人:0=非经纪人；1=经纪人
    this.inviteUrl, // 邀请链接
    this.inviteCode, // 邀请码
    this.inviteQECode, //邀请二维码
    this.agentSiteUrl, //经纪人后台地址，不是经纪人才成为经纪人后才有
  });

  factory UserAgentInfo.fromRawJson(String str) =>
      UserAgentInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserAgentInfo.fromJson(Map<String, dynamic> json) => UserAgentInfo(
        roleName: json["roleName"],
        roleType: json["roleType"],
        scaleReturn: json["scaleReturn"],
        amountTotal: json["amountTotal"],
        amountYesterday: json["amountYesterday"],
        userCount: json["userCount"],
        coAgentStatus: json["coAgentStatus"],
        coin: json["coin"],
        totalNumber: json["totalNumber"],
        agentApplyFormUrl: json["agent_apply_form_url"],
        agentStatus: json["agentStatus"],
        inviteUrl: json["inviteUrl"],
        inviteCode: json["inviteCode"],
        inviteQECode: json["inviteQECode"],
        agentSiteUrl: json["agent_site_url"],
      );

  Map<String, dynamic> toJson() => {
        "roleName": roleName,
        "roleType": roleType,
        "scaleReturn": scaleReturn,
        "amountTotal": amountTotal,
        "amountYesterday": amountYesterday,
        "userCount": userCount,
        "coAgentStatus": coAgentStatus,
        "coin": coin,
        "totalNumber": totalNumber,
        "agent_apply_form_url": agentApplyFormUrl,
        "agentStatus": agentStatus,
        "inviteUrl": inviteUrl,
        "inviteCode": inviteCode,
        "inviteQECode": inviteQECode,
        "agent_site_url": agentSiteUrl
      };
}

class OtcCompanyInfo {
  String? marginCoinSymbol;
  String? otcCompanyApplyEmail;
  String? normalTradeLimit;
  String? normalCompanyMarginNum;
  String? status;

  OtcCompanyInfo({
    this.marginCoinSymbol,
    this.otcCompanyApplyEmail,
    this.normalTradeLimit,
    this.normalCompanyMarginNum,
    this.status,
  });

  factory OtcCompanyInfo.fromRawJson(String str) =>
      OtcCompanyInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OtcCompanyInfo.fromJson(Map<String, dynamic> json) => OtcCompanyInfo(
        marginCoinSymbol: json["marginCoinSymbol"],
        otcCompanyApplyEmail: json["otcCompanyApplyEmail"],
        normalTradeLimit: json["normalTradeLimit"],
        normalCompanyMarginNum: json["normalCompanyMarginNum"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "marginCoinSymbol": marginCoinSymbol,
        "otcCompanyApplyEmail": otcCompanyApplyEmail,
        "normalTradeLimit": normalTradeLimit,
        "normalCompanyMarginNum": normalCompanyMarginNum,
        "status": status,
      };
}

class UserCompanyInfo {
  String? otcCompanyMarginNum;
  String? applyStatus;
  String? status;

  UserCompanyInfo({
    this.otcCompanyMarginNum,
    this.applyStatus,
    this.status,
  });

  factory UserCompanyInfo.fromRawJson(String str) =>
      UserCompanyInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserCompanyInfo.fromJson(Map<String, dynamic> json) =>
      UserCompanyInfo(
        otcCompanyMarginNum: json["otcCompanyMarginNum"],
        applyStatus: json["applyStatus"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "otcCompanyMarginNum": otcCompanyMarginNum,
        "applyStatus": applyStatus,
        "status": status,
      };
}

class VerificationDataModel {
  String? showAccount;
  String? typeList;
  String? account;
  String? country;
  String? type;
  String? token;
  String? googleAuth;
  bool isMask; //是否需要脱敏

  VerificationDataModel(
      {this.showAccount,
      this.typeList,
      this.account,
      this.country,
      this.type,
      this.token,
      this.googleAuth,
      this.isMask = true});

  factory VerificationDataModel.fromRawJson(String str) =>
      VerificationDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VerificationDataModel.fromJson(Map<String, dynamic> json) =>
      VerificationDataModel(
        showAccount: json["showAccount"],
        typeList: json["typeList"],
        account: json["account"],
        country: json["country"],
        type: json["type"],
        token: json["token"],
        googleAuth: json["googleAuth"],
        isMask: json["isMask"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "showAccount": showAccount,
        "typeList": typeList,
        "account": account,
        "country": country,
        "type": type,
        "token": token,
        "googleAuth": googleAuth,
        "isMask": isMask,
      };
}

class ResetPasswordStepModel {
  String? isCertificateNumber;
  String? isGoogleAuth;
  String? token;

  ResetPasswordStepModel({
    this.isCertificateNumber,
    this.isGoogleAuth,
    this.token,
  });

  factory ResetPasswordStepModel.fromRawJson(String str) =>
      ResetPasswordStepModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResetPasswordStepModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordStepModel(
        isCertificateNumber: json["isCertificateNumber"],
        isGoogleAuth: json["isGoogleAuth"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "isCertificateNumber": isCertificateNumber,
        "isGoogleAuth": isGoogleAuth,
        "token": token,
      };
}

class UsertoopegoogleModel {
  String? googleKey;
  String? googleImg;
  String? googleUser;

  UsertoopegoogleModel({
    this.googleKey,
    this.googleImg,
    this.googleUser,
  });

  factory UsertoopegoogleModel.fromRawJson(String str) =>
      UsertoopegoogleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UsertoopegoogleModel.fromJson(Map<String, dynamic> json) =>
      UsertoopegoogleModel(
        googleKey: json["googleKey"],
        googleImg: json["googleImg"],
        googleUser: json["googleUser"],
      );

  Map<String, dynamic> toJson() => {
        "googleKey": googleKey,
        "googleImg": googleImg,
        "googleUser": googleUser,
      };
}
