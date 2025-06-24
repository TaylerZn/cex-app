class WSReceiveData {
  String? channel;
  String? eventRep;
  int? ts;
  String? status;
  String? event;
  dynamic data;
  Map<String, dynamic>? tick;

  WSReceiveData({
    required this.channel,
    required this.eventRep,
    required this.ts,
    required this.status,
    this.data,
    this.tick,
    this.event,
  });

  factory WSReceiveData.fromJson(Map<String, dynamic> json) {
    return WSReceiveData(
      channel: json["channel"],
      eventRep: json["event_rep"],
      ts: json["ts"],
      event: json['event'],
      status: json["status"],
      data: json["data"],
      tick: json["tick"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chanel': channel,
      'event_rep': eventRep,
      'ts': ts,
      'status': status,
      'data': data,
      'event':event,
      'tick': tick,
    };
  }
}
