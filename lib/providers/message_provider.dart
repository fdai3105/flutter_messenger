import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_chat/config/constants.dart';
import 'package:flutter_bloc_chat/config/fields.dart';
import 'package:flutter_bloc_chat/config/paths.dart';
import 'package:flutter_bloc_chat/utils/shared_pres.dart';

import '../models/message.dart';

class MessageProvider {
  final FirebaseFirestore fireStore;

  StreamController<List<Message>> messageStreamControl;

  MessageProvider({FirebaseFirestore fireStore})
      : fireStore = fireStore ?? FirebaseFirestore.instance;

  Stream<List<Message>> getMessages(String chatID) {
    messageStreamControl = StreamController();
    messageStreamControl.sink;

    final doc = fireStore.collection(Paths.chatsPath).doc(chatID);
    final messages = doc.collection(Paths.messagesPath);
    return messages.snapshots().transform(
        StreamTransformer<QuerySnapshot, List<Message>>.fromHandlers(
            handleData: (snapshot, sink) =>
                Message.fromQuerySnapShot(snapshot, sink)
        ));
  }

  Future<List<Message>> getPreviousMessages(String chatId,
      Message prevMessage) {}

  Future<void> sendMessage(String chatId, Message message) async {
    final chatDocRef = fireStore.collection(Paths.chatsPath).doc(chatId);
    final messagesCollection = chatDocRef.collection(Paths.messagesPath);
    await messagesCollection.add(message.toMap());
    await chatDocRef.set({
      "belongToChatID": chatId,
      Fields.chatFieldsLastMessage: message.toMap(),
      "members": [SharedPres.getUser().email, "test"]
    });
  }
}
