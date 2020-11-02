part of 'models.dart';

class Room {
  final String chatId;
  final LastMessage latestMessage;
  final List<Contact> members;

  Room({this.chatId, this.latestMessage, this.members});

  @override
  String toString() {
    return 'Conversation{chatId: $chatId, latestMessage: $latestMessage, members: $members}';
  }
}
