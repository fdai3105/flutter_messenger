import 'package:flutter/material.dart';
import '../config/config.dart';

class LastMessage {
  String text;
  String sendName;
  int time;

  LastMessage({this.text, this.sendName, this.time});

  factory LastMessage.fromMap(Map data) {
    return LastMessage(
      text: data[Fields.romText],
      sendName: data[Fields.roomSenderName],
      time: data[Fields.romTime],
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map[Fields.romText] = text;
    map[Fields.roomSenderName] = sendName;
    map[Fields.romTime] = time;
    return map;
  }

  @override
  String toString() {
    return 'LastMessage{text: $text, sendBy: $sendName, time: $time}';
  }
}
