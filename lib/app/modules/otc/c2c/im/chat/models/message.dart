class C2CMessage {
  String orderId;
  String from;
  String to;
  String content;
  int? chatId;
  int? timestamp;
  String timeStr = '';

  C2CMessage({
    required this.orderId,
    required this.from,
    required this.to,
    required this.content,
    required this.timestamp,
    this.chatId,
  });

  C2CMessage copyWith({
    String? orderId,
    String? from,
    String? to,
    String? content,
    int? chatId,
    int? timestamp,
  }) {
    return C2CMessage(
      orderId: orderId ?? this.orderId,
      from: from ?? this.from,
      to: to ?? this.to,
      content: content ?? this.content,
      chatId: chatId ?? this.chatId,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'from': from,
      'to': to,
      'content': content,
      'chatId': chatId,
      'ctime': timestamp,
    };
  }

  factory C2CMessage.fromJson(Map<String, dynamic> map) {
    return C2CMessage(
      orderId: map['orderId'],
      from: map['from'],
      to: map['to'],
      content: map['content'],
      chatId: map['chatId'],
      timestamp: map['ctime'],
    );
  }
}
