
class CreateOrderRes {
  List<String> ids;
  List<dynamic> cancelIds;

  CreateOrderRes({
    required this.ids,
    required this.cancelIds,
  });

  factory CreateOrderRes.fromJson(Map<String, dynamic> json) => CreateOrderRes(
    ids: List<String>.from(json["ids"].map((x) => x)),
    cancelIds: List<dynamic>.from(json["cancelIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ids": List<dynamic>.from(ids.map((x) => x)),
    "cancelIds": List<dynamic>.from(cancelIds.map((x) => x)),
  };
}
