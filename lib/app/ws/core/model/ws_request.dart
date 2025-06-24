// To parse this JSON data, do
//
//     final wsRequest = wsRequestFromJson(jsonString);

import 'dart:convert';

WsRequest wsRequestFromJson(String str) => WsRequest.fromJson(json.decode(str));

String wsRequestToJson(WsRequest data) => json.encode(data.toJson());

class WsRequest {
  String event;
  String? token;
  String channel;
  String? lang;
  Map? params;
  String? action;


  WsRequest({
    required this.event,
    this.token,
    this.lang,
    required this.channel,
    this.params,
     this.action
  });

  factory WsRequest.fromJson(Map<String, dynamic> json) => WsRequest(
    event: json["event"],
    token: json["token"],
    lang: json["lang"],
    params: json["params"],
    channel: json['channel'],
  );

  Map<String, dynamic> toJson() => {
    "event": event,
    "token": token,
    'channel':channel,
    'action':action,
    "lang": lang,
    "params": params,
  };
}

