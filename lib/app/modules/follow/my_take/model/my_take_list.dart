class MyTakefollowUserList {
  int? count;
  List<MyTakefollowUser> list = [];
  MyTakefollowUserList();
  MyTakefollowUserList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = <MyTakefollowUser>[];
      json['list'].forEach((v) {
        list.add(MyTakefollowUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['list'] = list.map((v) => v.toJson()).toList();

    return data;
  }
}

class MyTakefollowUser {
  num? uid;
  num total = 0;
  num? followTime;
  num? followType;
  num? followProfit;
  String username = '--';
  MyTakefollowUser();
  MyTakefollowUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    total = json['total'] ?? 0;
    followTime = json['followTime'];
    followType = json['followType'];
    followProfit = json['followProfit'];
    username = json['username'] ?? '--';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['total'] = total;
    data['followTime'] = followTime;
    data['followType'] = followType;
    data['followProfit'] = followProfit;
    data['username'] = username;
    return data;
  }

  String get icon => 'https://mcd.merchain.live/app_operation_static/vendor/img/kolTradersList-head.a0525ea.png';
  String get totalStr => total.toStringAsFixed(2);
}
