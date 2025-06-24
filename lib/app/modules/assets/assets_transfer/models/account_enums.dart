class AssetsTransferItemModel {
  int id;
  String name;
  String request;
  String? c2cRequest;
  List<int> supportIdList;

  AssetsTransferItemModel({
    required this.id,
    required this.name,
    this.request = '',
    this.c2cRequest,
    required this.supportIdList,
  });

  factory AssetsTransferItemModel.fromJson(Map<String, dynamic> json) =>
      AssetsTransferItemModel(
        id: json["id"],
        name: json["name"],
        request: json["request"],
        c2cRequest: json["c2cRequest"],
        supportIdList: json["supportIdList"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "request": request,
        "c2cRequest": c2cRequest,
        "supportIdList": supportIdList,
      };
}
