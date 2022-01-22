class Message {
  int id;
  int senderId;
  int receiverId;
  String content;
  String createdAt;
  String updatedAt;
  String type;

  Message(
      {this.id,
      this.senderId,
      this.receiverId,
      this.content,
      this.createdAt,
      this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Messages {
  final List<dynamic> messageList;

  Messages({this.messageList});

  factory Messages.fromjson(List<dynamic> jsonData) {
    return Messages(
      messageList: jsonData,
    );
  }
}
