part of 'chat_bloc.dart';

abstract class ChatsState extends Equatable {
  const ChatsState();
}

// Chats
class InitialChatsState extends ChatsState {
  @override
  List<Object> get props => [];
}

class FetchingChatsState extends ChatsState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class FetchedChatsState extends ChatsState {
  @override
  List<Object> get props => throw UnimplementedError();
}
