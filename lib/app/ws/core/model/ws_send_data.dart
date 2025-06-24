abstract class SubEvent {
  static const req = 'req';
  static const sub = 'sub';
  static const unSub = 'unsub';
  static const subBatch = 'sub_batch';
  static const unSubBatch = 'unsub_batch';
}

class WsSendData {
  String event;
  String? action;
  String channel;
  String? cbId;

  String? cid;
  int? asks;
  int? bids;
  String? top;
  String? cb_id;
  int? pageSize;
  int? endIdx;
  Map<String,dynamic>? params;
  String? token;
  String? lang;

  WsSendData({
    required this.event,
    required this.channel,
    this.cbId,
    this.cb_id,
    this.cid,
    this.asks,
    this.bids,
    this.params,
    this.top,
    this.pageSize,
    this.action,
    this.endIdx,
    this.token,
    this.lang
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WsSendData &&
          runtimeType == other.runtimeType &&
          event == other.event &&
          channel == other.channel &&
          cbId == other.cbId &&
          cid == other.cid &&
          asks == other.asks &&
          bids == other.bids &&
          top == other.top &&
          pageSize == other.pageSize &&
          endIdx == other.endIdx;

  @override
  int get hashCode =>
      event.hashCode ^
      channel.hashCode ^
      cbId.hashCode ^
      cid.hashCode ^
      asks.hashCode ^
      bids.hashCode ^
      top.hashCode ^
      pageSize.hashCode ^
      endIdx.hashCode;

  String get key =>
      "$event-$channel-$cbId-$cid-$asks-$bids-$top-$pageSize-$endIdx";

  /// 订阅
  factory WsSendData.sub({
    required String channel,
    String? cbId,
    String? cid,
    int? asks,
    int? bids,
    String? top,
    int? pageSize,
    int? endIdx,
  }) {
    return WsSendData(
        event: SubEvent.sub,
        channel: channel,
        cbId: cbId,
        cid: cid,
        asks: asks,
        bids: bids,
        top: top,
        pageSize: pageSize,
        endIdx: endIdx);
  }

  /// 取消订阅
  factory WsSendData.unsub({
    required String channel,
    String? cbId,
    String? cid,
    int? asks,
    int? bids,
    String? top,
    int? pageSize,
    int? endIdx,
  }) {
    return WsSendData(
        event: SubEvent.unSub,
        channel: channel,
        cbId: cbId,
        cid: cid,
        asks: asks,
        bids: bids,
        top: top,
        pageSize: pageSize,
        endIdx: endIdx);
  }

  /// 请求
  factory WsSendData.req({
    required String channel,
    String? cbId,
    String? cid,
    int? asks,
    int? bids,
    String? cb_id,
    String? top,
    int? pageSize,
    int? endIdx,
  }) {
    return WsSendData(
      event: SubEvent.req,
      channel: channel,
      cbId: cbId,
      cid: cid,
      asks: asks,
      bids: bids,
      cb_id: cb_id,
      top: top,
      pageSize: pageSize,
      endIdx: endIdx,
    );
  }

  /// 批量订阅
  factory WsSendData.subBatch({
    required String channel,
    String? cbId,
    String? cid,
    int? asks,
    int? bids,
    String? top,
    int? pageSize,
    int? endIdx,
  }) {
    return WsSendData(
      event: SubEvent.subBatch,
      channel: channel,
      cbId: cbId,
      cid: cid,
      asks: asks,
      bids: bids,
      top: top,
      pageSize: pageSize,
      endIdx: endIdx,
    );
  }

  /// 批量取消订阅
  factory WsSendData.unsubBatch({
    required String channel,
    String? cbId,
    String? cid,
    int? asks,
    int? bids,
    String? top,
    int? pageSize,
    int? endIdx,
  }) {
    return WsSendData(
        event: SubEvent.unSubBatch,
        channel: channel,
        cbId: cbId,
        cid: cid,
        asks: asks,
        bids: bids,
        top: top,
        pageSize: pageSize,
        endIdx: endIdx);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> params = {
      "channel": channel,
      "cb_id": cbId,
      'cid': cid,
      "asks": asks,
      "bids": bids,
      "top": top,
      "pageSize": pageSize,
      'params' : this.params,
      'token':token,
      'lang':lang,

      "endIdx": endIdx,
    }..removeWhere((key, value) => value == null);

    return {"event": event, "params": params};
  }
}
