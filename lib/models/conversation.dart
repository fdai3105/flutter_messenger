import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_chat/models/user.dart';
import 'package:flutter_bloc_chat/utils/shared_pres.dart';
import '../config/fields.dart';

import '../config/constants.dart';
import 'Message.dart';

class Conversation {
  final String chatId;
  final Message latestMessage;
  final String user;
  final List<String> members;

  Conversation({this.chatId, this.latestMessage, this.user, this.members});

  factory Conversation.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data();
    final _members = <String>[];
    final selfEmail = SharedPres.getUser().email;
    final memberEmails = List<String>.from(data["members"]);
    for (var i = 0; i < memberEmails.length; i++) {
      if (memberEmails[i] != selfEmail) {
        _members.add(memberEmails[i]);
      }
    }

    return Conversation(
        chatId: doc.id,
        latestMessage:
            Message.fromMap(Map.from(data[Fields.chatFieldsLastMessage])),
        user: selfEmail,
        members: _members);
  }

  // ignore: missing_return
  factory Conversation.fromQuerySnapShot(
      QuerySnapshot querySnapshot, EventSink<List<Conversation>> sink) {
    final conversations = <Conversation>[];
    querySnapshot.docs.forEach((document) {
      conversations.add(Conversation.fromFireStore(document));
    });
    sink.add(conversations);
  }

  @override
  String toString() {
    return 'Conversation{chatId: $chatId, latestMessage: $latestMessage, user: $user, members: $members}';
  }
}
