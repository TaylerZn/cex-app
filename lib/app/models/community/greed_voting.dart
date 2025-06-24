// To parse this JSON data, do
//
//     final greedVotingModel = greedVotingModelFromJson(jsonString);

import 'dart:convert';

GreedVotingModel greedVotingModelFromJson(String str) => GreedVotingModel.fromJson(json.decode(str));

String greedVotingModelToJson(GreedVotingModel data) => json.encode(data.toJson());

class GreedVotingModel {
  List<VoteRecord>? records;

  GreedVotingModel({
    this.records,
  });

  factory GreedVotingModel.fromJson(Map<String, dynamic> json) => GreedVotingModel(
    records: json["records"] == null ? [] : List<VoteRecord>.from(json["records"]!.map((x) => VoteRecord.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "records": records == null ? [] : List<dynamic>.from(records!.map((x) => x.toJson())),
  };
}

class VoteRecord {
  int? topicVoteId;
  String? votingOption;
  int? votingNum;
  int? votingPercentage;
  bool? votedByMe;

  VoteRecord({
    this.topicVoteId,
    this.votingOption,
    this.votingNum,
    this.votingPercentage,
    this.votedByMe,
  });

  factory VoteRecord.fromJson(Map<String, dynamic> json) => VoteRecord(
    topicVoteId: json["topicVoteId"],
    votingOption: json["votingOption"],
    votingNum: json["votingNum"],
    votingPercentage: json["votingPercentage"],
    votedByMe: json["votedByMe"],
  );

  Map<String, dynamic> toJson() => {
    "topicVoteId": topicVoteId,
    "votingOption": votingOption,
    "votingNum": votingNum,
    "votingOptionRate": votingPercentage,
    "votedByMe": votedByMe,
  };
}
