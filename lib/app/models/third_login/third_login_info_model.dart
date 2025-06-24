class ThirdLoginInfoModel {
  ThirdLoginInfoModel({
    required this.apple,
    required this.google,
    required this.telegram,
  });

  final ThirdDetail? apple;
  static const String appleKey = "apple";

  final ThirdDetail? google;
  static const String googleKey = "google";

  final ThirdDetail? telegram;
  static const String telegramKey = "telegram";

  ThirdLoginInfoModel copyWith({
    ThirdDetail? apple,
    ThirdDetail? google,
    ThirdDetail? telegram,
  }) {
    return ThirdLoginInfoModel(
      apple: apple ?? this.apple,
      google: google ?? this.google,
      telegram: telegram ?? this.telegram,
    );
  }

  factory ThirdLoginInfoModel.fromJson(Map<String, dynamic> json) {
    return ThirdLoginInfoModel(
      apple: json["apple"] == null ? null : ThirdDetail.fromJson(json["apple"]),
      google:
          json["google"] == null ? null : ThirdDetail.fromJson(json["google"]),
      telegram: json["telegram"] == null
          ? null
          : ThirdDetail.fromJson(json["telegram"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "apple": apple?.toJson(),
        "google": google?.toJson(),
        "telegram": telegram?.toJson(),
      };

  @override
  String toString() {
    return "$apple, $google, $telegram, ";
  }
}

class ThirdDetail {
  ThirdDetail({
    required this.userAccount,
    required this.isAuth,
  });

  final String userAccount;
  static const String userAccountKey = "userAccount";

  final String isAuth;
  static const String isAuthKey = "isAuth";

  ThirdDetail copyWith({
    String? userAccount,
    String? isAuth,
  }) {
    return ThirdDetail(
      userAccount: userAccount ?? this.userAccount,
      isAuth: isAuth ?? this.isAuth,
    );
  }

  factory ThirdDetail.fromJson(Map<String, dynamic> json) {
    return ThirdDetail(
      userAccount: json["userAccount"] ?? "",
      isAuth: json["isAuth"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "userAccount": userAccount,
        "isAuth": isAuth,
      };

  @override
  String toString() {
    return "$userAccount, $isAuth, ";
  }
}
