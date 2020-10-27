import 'dart:async';

import '../providers/message_provider.dart';

import '../models/message.dart';
import 'base_repository.dart';

class MessageRepository extends BaseRepository {
  final _messageProvider = MessageProvider();

  Future<void> sendMessage(String chatId, Message message) =>
      _messageProvider.sendMessage(chatId, message);

  Stream<List<Message>> getMessages(String chatId) =>
      _messageProvider.getMessages(chatId);

  Future<List<Message>> getPreviousMessages(String chatID, Message prevMess) =>
      _messageProvider.getPreviousMessages(chatID, prevMess);

  @override
  void dispose() {}
}
