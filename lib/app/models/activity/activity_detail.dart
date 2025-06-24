class ActivityDetail {
  int? id;
  String? activityId;
  String? lang;
  String? name;
  String? title;
  String? whiteImg;
  String? blackImg;
  String? startTime;
  String? endTime;
  String? inviteCode;
  /// 0：未报名，1：已报
  int? status;
  int? totalAmount;
  int? dealAmount;

  ActivityDetail(
      {this.id,
        this.activityId,
        this.lang,
        this.name,
        this.title,
        this.whiteImg,
        this.blackImg,
        this.startTime,
        this.endTime,
        this.inviteCode,
        this.status,
        this.totalAmount,
        this.dealAmount});

  ActivityDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityId = json['activityId'];
    lang = json['lang'];
    name = json['name'];
    title = json['title'];
    whiteImg = json['whiteImg'];
    blackImg = json['blackImg'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    inviteCode = json['inviteCode'];
    status = json['status'];
    totalAmount = json['totalAmount'];
    dealAmount = json['dealAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activityId'] = this.activityId;
    data['lang'] = this.lang;
    data['name'] = this.name;
    data['title'] = this.title;
    data['whiteImg'] = this.whiteImg;
    data['blackImg'] = this.blackImg;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['inviteCode'] = this.inviteCode;
    data['status'] = this.status;
    data['totalAmount'] = this.totalAmount;
    data['dealAmount'] = this.dealAmount;
    return data;
  }
}
