part of '../blocs.dart';

class RoomBloc extends Bloc<RoomEvent, ConversationState> {
  final RoomRepository conversationRepository;

  RoomBloc(this.conversationRepository) : super(RoomInitial());

  @override
  Stream<ConversationState> mapEventToState(RoomEvent event) async* {
    if (event is FetchRoomEvent) {
      yield* _mapFetchConversationEventToState();
    } else if (event is ReceiveRoomEvent) {
      yield RoomProgress();
      yield RoomSuccess(event.conversations);
    }
  }

  Stream<ConversationState> _mapFetchConversationEventToState() async* {
    conversationRepository.getConversations().listen((event) {
      add(ReceiveRoomEvent(event));
    });
  }


}
