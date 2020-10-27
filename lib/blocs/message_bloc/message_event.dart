part of 'message_bloc.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();
}

class FetchMessagesEvent extends MessagesEvent {
  final String chatID;

  const FetchMessagesEvent(this.chatID);

  @override
  List<Object> get props => [chatID];

  @override
  String toString() {
    return 'FetchMessagesEvent{chatID: $chatID}';
  }
}

class ReceiveMessagesEvent extends MessagesEvent {
  final List<Message> messages;

  const ReceiveMessagesEvent(this.messages);

  @override
  List<Object> get props => [messages];

  @override
  String toString() {
    return 'ReceiveMessagesEvent{messages: $messages}';
  }
}

class SendMessageEvent extends MessagesEvent {
  final String chatsID;
  final Message message;

  const SendMessageEvent(this.chatsID,this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return 'SendMessageEvent{message: $message}';
  }
}
