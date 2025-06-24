
import 'dart:convert';

class OptionRecommendContractId {
  String recommendIds;
  String collectIds;

  OptionRecommendContractId({
    required this.recommendIds,
    required this.collectIds,
  });

  factory OptionRecommendContractId.fromJson(Map<String, dynamic> json) => OptionRecommendContractId(
        recommendIds: json["recommendIds"] ?? '',
        collectIds: json["collectIds"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "recommendIds": recommendIds,
        "collectIds": collectIds,
      };
}
