// import 'dart:convert';

// class Data {
//   dynamic notices;
//   dynamic markets;
//   dynamic traders;
//   dynamic functions;
//   dynamic topics;
//   dynamic questions;
//   dynamic stdFuturesOptionals;
//   dynamic optionals;
//   dynamic futures;
//   dynamic futuresOptionals;

//   Data({
//     this.notices,
//     this.markets,
//     this.traders,
//     this.functions,
//     this.topics,
//     this.questions,
//     this.stdFuturesOptionals,
//     this.optionals,
//     this.futures,
//     this.futuresOptionals,
//   });

//   factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         notices: json["notices"] == null
//             ? null
//             : Functions.fromJson(json["notices"]),
//         markets: json["markets"] == null
//             ? null
//             : Functions.fromJson(json["markets"]),
//         traders: json["traders"] == null
//             ? null
//             : Functions.fromJson(json["traders"]),
//         functions: json["functions"] == null
//             ? null
//             : Functions.fromJson(json["functions"]),
//         topics:
//             json["topics"] == null ? null : Functions.fromJson(json["topics"]),
//         questions: json["questions"] == null
//             ? null
//             : Functions.fromJson(json["questions"]),
//         stdFuturesOptionals: json["stdFuturesOptionals"] == null
//             ? null
//             : Functions.fromJson(json["stdFuturesOptionals"]),
//         optionals: json["optionals"] == null
//             ? null
//             : Functions.fromJson(json["optionals"]),
//         futures: json["futures"] == null
//             ? null
//             : Functions.fromJson(json["futures"]),
//         futuresOptionals: json["futuresOptionals"] == null
//             ? null
//             : Functions.fromJson(json["futuresOptionals"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "notices": notices?.toJson(),
//         "markets": markets?.toJson(),
//         "traders": traders?.toJson(),
//         "functions": functions?.toJson(),
//         "topics": topics?.toJson(),
//         "questions": questions?.toJson(),
//         "stdFuturesOptionals": stdFuturesOptionals?.toJson(),
//         "optionals": optionals?.toJson(),
//         "futures": futures?.toJson(),
//         "futuresOptionals": futuresOptionals?.toJson(),
//       };
// }

import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';

class SearchHotTrades {
  List<ContractInfo>? list;

  SearchHotTrades({this.list});

  SearchHotTrades.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      ObjectKV.recommend.set(json);

      list = <ContractInfo>[];
      json['list'].forEach((v) {
        list!.add(ContractInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
