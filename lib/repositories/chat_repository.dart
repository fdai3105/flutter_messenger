import 'dart:async';
import '../models/chat.dart';
import '../providers/chat_provider.dart';

import 'base_repository.dart';

class ChatRepository extends BaseRepository {
  ChatProvider chatProvider = ChatProvider();

  Future<List<Chat>> getChats() => chatProvider.getChats();

  @override
  void dispose() {}
}
