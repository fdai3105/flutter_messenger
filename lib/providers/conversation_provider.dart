import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_chat/config/constants.dart';
import 'package:flutter_bloc_chat/config/fields.dart';
import 'package:flutter_bloc_chat/utils/shared_pres.dart';
import '../config/paths.dart';

import '../models/conversation.dart';

class ConversationProvider {
  final FirebaseFirestore fireStore;

  StreamController<List<Conversation>> conversationStreamController;

  ConversationProvider({FirebaseFirestore fireStore})
      : fireStore = fireStore ?? FirebaseFirestore.instance;

  Stream<List<Conversation>> getConversations() {
    conversationStreamController = StreamController();
    conversationStreamController.sink;
    final currentEmail = SharedPres.getUser().email;
    return fireStore
        .collection(Paths.chatsPath)
        .where(Fields.chatFieldsMember, arrayContains: currentEmail)
        .orderBy("lastMessage.time", descending: true)
        .snapshots()
        .transform(
            StreamTransformer<QuerySnapshot, List<Conversation>>.fromHandlers(
                handleData: (data, sink) =>
                    Conversation.fromQuerySnapShot(data, sink)));
  }
}
