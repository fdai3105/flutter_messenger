import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_chat/config/constants.dart';
import 'package:flutter_bloc_chat/models/chat.dart';
import '../config/fields.dart';
import '../config/paths.dart';

import '../models/message.dart';

class ChatProvider {
  final FirebaseFirestore fireStore;

  ChatProvider({FirebaseFirestore fireStore})
      : fireStore = fireStore ?? FirebaseFirestore.instance;

  Future<List<Chat>> getChats() {
    return null;
  }
}
