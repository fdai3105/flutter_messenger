part of "repositories.dart";

class MessageRepository implements Repository {
  final _messageProvider = MessageProvider();

  Future<void> sendMessage(String chatId, Message message, String sendTo) =>
      _messageProvider.sendMessage(chatId, message, sendTo);

  Stream<List<Message>> getMessages(String chatId) =>
      _messageProvider.getMessages(chatId);

  Future<List<Message>> getPreviousMessages(String chatID, Message prevMess) =>
      _messageProvider.getPreviousMessages(chatID, prevMess);

  @override
  void dispose() => _messageProvider.dispose();
}
