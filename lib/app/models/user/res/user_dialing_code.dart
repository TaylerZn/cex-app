class UserDialingCode {
  UserDialingCode({
    required this.dialingCode,
  });

  final String dialingCode;
  static const String dialingCodeKey = "dialingCode";

  UserDialingCode copyWith({
    String? dialingCode,
  }) {
    return UserDialingCode(
      dialingCode: dialingCode ?? this.dialingCode,
    );
  }

  factory UserDialingCode.fromJson(Map<String, dynamic> json) {
    return UserDialingCode(
      dialingCode: json["dialingCode"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "dialingCode": dialingCode,
      };

  @override
  String toString() {
    return "$dialingCode, ";
  }
}
