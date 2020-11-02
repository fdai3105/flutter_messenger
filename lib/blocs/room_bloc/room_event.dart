part of '../blocs.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();
}

class FetchRoomEvent extends RoomEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'FetchConversationEvent{}';
  }
}

class ReceiveRoomEvent extends RoomEvent {
  final List<Room> conversations;

  const ReceiveRoomEvent(this.conversations);

  @override
  List<Object> get props => [conversations];

  @override
  String toString() {
    return 'ListenConversationEvent{_conversations: $conversations}';
  }
}