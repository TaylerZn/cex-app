
class SystemMessageRes {
  List<SystemMessageInfo> data;
  int total;
  int totalPage;
  int pageSize;
  int currentPage;

  SystemMessageRes({
    required this.data,
    required this.total,
    required this.totalPage,
    required this.pageSize,
    required this.currentPage,
  });

  factory SystemMessageRes.fromJson(Map<String, dynamic> json) => SystemMessageRes(
    data: List<SystemMessageInfo>.from(json["data"].map((x) => SystemMessageInfo.fromJson(x))),
    total: json["total"],
    totalPage: json["totalPage"],
    pageSize: json["pageSize"],
    currentPage: json["currentPage"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
    "totalPage": totalPage,
    "pageSize": pageSize,
    "currentPage": currentPage,
  };
}

class SystemMessageInfo {
  int id;
  int type; // 消息类型（1：充值 2：提现 3：开单 4：平单）
  int read; // 是否已读（0：未读 1：已读
  String content;
  String createTime;

  SystemMessageInfo({
    required this.id,
    required this.type,
    required this.read,
    required this.content,
    required this.createTime,
  });

  factory SystemMessageInfo.fromJson(Map<String, dynamic> json) => SystemMessageInfo(
    id: json["id"],
    type: json["type"],
    read: json["read"],
    content: json["content"],
    createTime: json["createTime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "read": read,
    "content": content,
    "createTime": createTime,
  };
}
