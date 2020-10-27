import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_chat/repositories/chat_repository.dart';
import '../../models/chat.dart';
import '../../models/message.dart';

part 'chat_state.dart';

part 'chat_event.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final ChatRepository chatRepository;

  ChatsBloc(this.chatRepository) : super(InitialChatsState());

  @override
  Stream<ChatsState> mapEventToState(
    ChatsEvent event,
  ) async* {
    if (event is FetchChatsEvent) {
      yield* _mapFetchChatsEventToMap();
    }
  }

  Stream<ChatsState> _mapFetchChatsEventToMap() {
    chatRepository.getChats();
  }
}
