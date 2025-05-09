import 'dart:convert';

import 'package:sdock_fe/full_apps/m3/learning/models/mentor.dart';
import 'package:sdock_fe/full_apps/m3/learning/models/message.dart';
import 'package:flutter/services.dart';

class Chat {
  final Mentor mentor;
  final List<Message> messages;

  Chat(this.mentor, this.messages);

  static Future<List<Chat>> getDummyList() async {
    dynamic data = json.decode(await getData());
    return getListFromJson(data);
  }

  static Future<Chat> getOne() async {
    return (await getDummyList())[0];
  }

  static Chat fromJson(Map<String, dynamic> jsonObject) {
    Mentor mentor = Mentor.fromJson(jsonObject['mentor']);
    List<Message> messages = Message.getListFromJson(jsonObject['messages']);

    return Chat(mentor, messages);
  }

  static List<Chat> getListFromJson(List<dynamic> jsonArray) {
    List<Chat> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Chat.fromJson(jsonArray[i]));
    }
    return list;
  }

  static Future<String> getData() async {
    return await rootBundle
        .loadString('assets/full_apps/m3/learning/data/chats.json');
  }
}
