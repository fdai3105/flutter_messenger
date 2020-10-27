part of 'conversation_bloc.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();
}

class FetchConversationEvent extends ConversationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'FetchConversationEvent{}';
  }
}

class ReceiveConversationEvent extends ConversationEvent {
  final List<Conversation> conversations;

  const ReceiveConversationEvent(this.conversations);

  @override
  List<Object> get props => [conversations];

  @override
  String toString() {
    return 'ListenConversationEvent{_conversations: $conversations}';
  }
}