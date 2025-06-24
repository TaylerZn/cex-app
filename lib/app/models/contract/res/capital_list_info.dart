class CapitalListInfo {
  List<BrokenLineListElement> historyList;
  int count;
  List<BrokenLineListElement> brokenLineList;

  CapitalListInfo({
    required this.historyList,
    required this.count,
    required this.brokenLineList,
  });

  factory CapitalListInfo.fromJson(Map<String, dynamic> json) => CapitalListInfo(
    historyList: List<BrokenLineListElement>.from(json["historyList"].map((x) => BrokenLineListElement.fromJson(x))),
    count: json["count"],
    brokenLineList: List<BrokenLineListElement>.from(json["brokenLineList"].map((x) => BrokenLineListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "historyList": List<dynamic>.from(historyList.map((x) => x.toJson())),
    "count": count,
    "brokenLineList": List<dynamic>.from(brokenLineList.map((x) => x.toJson())),
  };
}

class BrokenLineListElement {
  double amount;
  int ctime;
  String contractName;

  BrokenLineListElement({
    required this.amount,
    required this.ctime,
    required this.contractName,
  });

  factory BrokenLineListElement.fromJson(Map<String, dynamic> json) => BrokenLineListElement(
    amount: json["amount"]?.toDouble(),
    ctime: json["ctime"],
    contractName: json["contractName"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "ctime": ctime,
    "contractName": contractName,
  };
}