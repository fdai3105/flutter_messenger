part of 'conversation_bloc.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();
}

class ConversationInitial extends ConversationState {
  @override
  List<Object> get props => [];
}

class ConversationProgress extends ConversationState {
  @override
  List<Object> get props => [];
}

class ConversationSuccess extends ConversationState {
  final List<Conversation> list;

  const ConversationSuccess(this.list);

  @override
  List<Object> get props => [list];
}

class ConversationFail extends ConversationState {
  const ConversationFail();

  @override
  List<Object> get props => [];
}
