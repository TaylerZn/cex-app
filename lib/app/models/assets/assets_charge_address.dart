class AssetsChargeAddress {
  String? addressStr;
  String? addressQrCode;
  int? depositConfirm;

  AssetsChargeAddress({
    this.addressStr,
    this.addressQrCode,
    this.depositConfirm,
  });

  factory AssetsChargeAddress.fromJson(Map<String, dynamic> json) =>
      AssetsChargeAddress(
        addressStr: json["addressStr"],
        addressQrCode: json["addressQRCode"],
        depositConfirm: json["depositConfirm"],
      );

  Map<String, dynamic> toJson() => {
        "addressStr": addressStr,
        "addressQRCode": addressQrCode,
        "depositConfirm": depositConfirm,
      };
}
