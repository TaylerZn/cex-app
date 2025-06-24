class ThirdLoginIsAuth {
  ThirdLoginIsAuth({
    required this.isAuth,
  });

  final String isAuth;
  static const String isAuthKey = "isAuth";

  ThirdLoginIsAuth copyWith({
    String? isAuth,
  }) {
    return ThirdLoginIsAuth(
      isAuth: isAuth ?? this.isAuth,
    );
  }

  factory ThirdLoginIsAuth.fromJson(Map<String, dynamic> json) {
    return ThirdLoginIsAuth(
      isAuth: json["isAuth"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "isAuth": isAuth,
      };

  @override
  String toString() {
    return "$isAuth, ";
  }
}
