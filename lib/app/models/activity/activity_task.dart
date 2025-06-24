class ActivityTask {
  String? activityId;
  String? taskDesc;
  String? taskTitle;
  String? type;
  /// 交易类型：1：永续合约 2：标准合约 3：跟单
  String? tradeType;
  String? tradeVolume;
  String? dealVolume;
  String? rewardsSymbol;
  String? rewardsTotal;
  String? ctime;
  String? mtime;
  /// 任务状态 0:进行中 1:已完成2:已结束
  int? status;
  int? rewardsCount;

  ActivityTask(
      {this.activityId,
        this.taskDesc,
        this.taskTitle,
        this.type,
        this.tradeType,
        this.tradeVolume,
        this.dealVolume,
        this.rewardsSymbol,
        this.rewardsTotal,
        this.ctime,
        this.mtime,
        this.status,
        this.rewardsCount});

  ActivityTask.fromJson(Map<String, dynamic> json) {
    activityId = json['activityId'];
    taskDesc = json['taskDesc'];
    taskTitle = json['taskTitle'];
    type = json['type'];
    tradeType = json['tradeType'];
    tradeVolume = json['tradeVolume'];
    dealVolume = json['dealVolume'];
    rewardsSymbol = json['rewardsSymbol'];
    rewardsTotal = json['rewardsTotal'];
    ctime = json['ctime'];
    mtime = json['mtime'];
    status = json['status'];
    rewardsCount = json['rewardsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activityId'] = activityId;
    data['taskDesc'] = taskDesc;
    data['taskTitle'] = taskTitle;
    data['type'] = type;
    data['tradeType'] = tradeType;
    data['tradeVolume'] = tradeVolume;
    data['dealVolume'] = dealVolume;
    data['rewardsSymbol'] = rewardsSymbol;
    data['rewardsTotal'] = rewardsTotal;
    data['ctime'] = ctime;
    data['mtime'] = mtime;
    data['status'] = status;
    data['rewardsCount'] = rewardsCount;
    return data;
  }

  taskStatus () {
    if (status == 0) {
      return TaskStatus.toComplete;
    } else if (status == 1) {
      return TaskStatus.completed;
    } else {
      return TaskStatus.end;
    }
  }
}

enum TaskStatus { completed, toComplete, end }