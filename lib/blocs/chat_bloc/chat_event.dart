part of 'chat_bloc.dart';

abstract class ChatsEvent extends Equatable {
  const ChatsEvent();
}

// Chats
class FetchChatsEvent extends ChatsEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'FetchChatsEvent{}';
  }
}

class ReceivedChatsEvent extends ChatsEvent {
  final List<Chat> chatList;

  const ReceivedChatsEvent(this.chatList);

  @override
  List<Object> get props => [chatList];

  @override
  String toString() {
    return 'ReceivedChatsEvent{}';
  }
}
