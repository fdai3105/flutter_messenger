part of '../blocs.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();
}

class RoomInitial extends ConversationState {
  @override
  List<Object> get props => [];
}

class RoomProgress extends ConversationState {
  @override
  List<Object> get props => [];
}

class RoomSuccess extends ConversationState {
  final List<Room> list;

  const RoomSuccess(this.list);

  @override
  List<Object> get props => [list];
}

class RoomFail extends ConversationState {
  const RoomFail();

  @override
  List<Object> get props => [];
}
