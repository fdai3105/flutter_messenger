part of 'message_bloc.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();
}

class MessagesInitial extends MessagesState {
  @override
  List<Object> get props => [];
}

class MessagesProgress extends MessagesState {
  @override
  List<Object> get props => [];
}

class MessagesSuccess extends MessagesState {
  final List<Message> messages;

  const MessagesSuccess(this.messages);

  @override
  List<Object> get props => [messages];
}

class MessagesFail extends MessagesState {
  @override
  List<Object> get props => [];
}
