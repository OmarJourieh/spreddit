import 'dart:convert';

import 'package:first_app/constants/api.dart';
import 'package:first_app/models/message.dart';
import 'package:first_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MessagesProvider extends ChangeNotifier {
  Future<List<User>> getAllConversations(int senderId) async {
    ConversationData cd = ConversationData(senderId: senderId);
    var res = await http.post(
      Uri.parse('$API/getconversations'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(cd),
    );
    String data = res.body;
    var jsonData = jsonDecode(data);
    Users users = Users.fromjson(jsonData);
    List<User> uList = users.userList.map((e) => User.fromJson(e)).toList();
    // items = bList;
    return uList;
  }

  Future<List<Message>> getConversationWithUser(
      int senderId, int receiverId) async {
    ConversationData cd =
        ConversationData(senderId: senderId, receiverId: receiverId);
    var res = await http.post(
      Uri.parse('$API/getallmessageswithuser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(cd),
    );

    String data = res.body;
    var jsonData = jsonDecode(data);
    Messages sentMessages = Messages.fromjson(jsonData["sent"]);
    List<Message> SMList =
        sentMessages.messageList.map((e) => Message.fromJson(e)).toList();

    for (var item in SMList) {
      item.type = "sent";
    }

    Messages receivedMessages = Messages.fromjson(jsonData["received"]);
    List<Message> RMList =
        receivedMessages.messageList.map((e) => Message.fromJson(e)).toList();
    for (var item in RMList) {
      item.type = "received";
    }

    List<Message> allMessages = SMList + RMList;

    allMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return allMessages;
  }

  Future<void> sendMessage(
      {int senderId, int receiverId, String content}) async {
    ConversationData cd = ConversationData(
        senderId: senderId, receiverId: receiverId, content: content);
    http.Response res = await http.post(
      Uri.parse("$API/sendmessage"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(cd),
    );
    notifyListeners();
  }
}

class ConversationData {
  final int senderId;
  final int receiverId;
  final String content;
  ConversationData({this.senderId, this.receiverId, this.content});

  Map<String, dynamic> toJson() => {
        "sender_id": senderId,
        "receiver_id": receiverId,
        "content": content,
      };
}
