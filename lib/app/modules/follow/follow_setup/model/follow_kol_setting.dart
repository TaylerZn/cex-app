import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';

class FollowkolSettingInfoModel with PagingError {
  FollowKolRecord? followRecord;
  FollowKolRecordInfo? info;

  FollowkolSettingInfoModel({this.followRecord, this.info});

  FollowkolSettingInfoModel.fromJson(Map<String, dynamic> json) {
    followRecord = json['followRecord'] != null ? FollowKolRecord.fromJson(json['followRecord']) : null;
    info = json['info'] != null ? FollowKolRecordInfo.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (followRecord != null) {
      data['followRecord'] = followRecord!.toJson();
    }
    if (info != null) {
      data['info'] = info!.toJson();
    }
    return data;
  }
}

class FollowKolRecord {
  num? total;
  num? isStopProfit;
  num followType = 1;
  num? singleTotal;
  num? isStopDeficit;
  num? stopDeficit;
  num? stopProfit;
  num? copyMode;

  FollowKolRecord(
      {this.total,
      this.isStopProfit,
      this.followType = 1,
      this.singleTotal,
      this.isStopDeficit,
      this.stopDeficit,
      this.stopProfit,
      this.copyMode});

  FollowKolRecord.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    isStopProfit = json['isStopProfit'];
    followType = json['followType'] ?? 1;
    singleTotal = json['singleTotal'];
    isStopDeficit = json['isStopDeficit'];
    stopDeficit = json['stopDeficit'];
    stopProfit = json['stopProfit'];
    copyMode = json['copyMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['isStopProfit'] = isStopProfit;
    data['followType'] = followType;
    data['singleTotal'] = singleTotal;
    data['isStopDeficit'] = isStopDeficit;
    data['stopDeficit'] = stopDeficit;
    data['stopProfit'] = stopProfit;
    data['copyMode'] = copyMode;
    return data;
  }
}

class FollowKolRecordInfo {
  num? totalNumber;
  num? isShare;
  num? winRateWeek;
  num? positionStatus;
  num? singleMaxAmount;
  String? userName;
  num? orderNumber;
  num? followStatus;
  String? label;
  num? shareRate;
  num? profitRate;
  num? profitAmount;
  num? uid;
  num? rate;
  num? dateDiff;
  String? imgUrl;
  num? singleMinAmount;
  num? winRate;
  num? orderFrequency;
  num? switchFollowerNumber;

  FollowKolRecordInfo(
      {this.totalNumber,
      this.isShare,
      this.winRateWeek,
      this.positionStatus,
      this.singleMaxAmount,
      this.userName,
      this.orderNumber,
      this.followStatus,
      this.label,
      this.shareRate,
      this.profitRate,
      this.profitAmount,
      this.uid,
      this.rate,
      this.dateDiff,
      this.imgUrl,
      this.singleMinAmount,
      this.winRate,
      this.orderFrequency,
      this.switchFollowerNumber});

  FollowKolRecordInfo.fromJson(Map<String, dynamic> json) {
    totalNumber = json['total_number'];
    isShare = json['is_share'];
    winRateWeek = json['win_rate_week'];
    positionStatus = json['position_status'];
    singleMaxAmount = json['single_max_amount'];
    userName = json['user_name'];
    orderNumber = json['order_number'];
    followStatus = json['follow_status'];
    label = json['label'];
    shareRate = json['share_rate'];
    profitRate = json['profit_rate'];
    profitAmount = json['profit_amount'];
    uid = json['uid'];
    rate = json['rate'];
    dateDiff = json['date_diff'];
    imgUrl = json['img_url'];
    singleMinAmount = json['single_min_amount'];
    winRate = json['win_rate'];
    orderFrequency = json['order_frequency'];
    switchFollowerNumber = json['switchFollowerNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_number'] = totalNumber;
    data['is_share'] = isShare;
    data['win_rate_week'] = winRateWeek;
    data['position_status'] = positionStatus;
    data['single_max_amount'] = singleMaxAmount;
    data['user_name'] = userName;
    data['order_number'] = orderNumber;
    data['follow_status'] = followStatus;
    data['label'] = label;
    data['share_rate'] = shareRate;
    data['profit_rate'] = profitRate;
    data['profit_amount'] = profitAmount;
    data['uid'] = uid;
    data['rate'] = rate;
    data['date_diff'] = dateDiff;
    data['img_url'] = imgUrl;
    data['single_min_amount'] = singleMinAmount;
    data['win_rate'] = winRate;
    data['order_frequency'] = orderFrequency;
    data['switchFollowerNumber'] = switchFollowerNumber;
    return data;
  }
}
