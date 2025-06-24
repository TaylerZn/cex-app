class OptionSpotSymbol {
  String syncStatus;
  List<String> symbols;
  List<String> recommendIds;

  OptionSpotSymbol({required this.syncStatus, required this.symbols, required this.recommendIds});

  factory OptionSpotSymbol.fromJson(Map<String, dynamic> json) => OptionSpotSymbol(
      syncStatus: json["sync_status"],
      symbols: List<String>.from(json["symbols"].map((x) => x)),
      recommendIds: json["recommendIds"] != null ? List<String>.from(json["recommendIds"].map((x) => x)) : []);

  Map<String, dynamic> toJson() => {
        "sync_status": syncStatus,
        "symbols": List<dynamic>.from(symbols.map((x) => x)),
        "recommendIds": List<dynamic>.from(recommendIds.map((x) => x)),
      };
}
