part of '../blocs.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository conversationRepository;

  ConversationBloc(this.conversationRepository) : super(ConversationInitial());

  @override
  Stream<ConversationState> mapEventToState(ConversationEvent event) async* {
    if (event is FetchConversationEvent) {
      yield* _mapFetchConversationEventToState();
    } else if (event is ReceiveConversationEvent) {
      yield ConversationProgress();
      yield ConversationSuccess(event.conversations);
    }
  }

  Stream<ConversationState> _mapFetchConversationEventToState() async* {
    conversationRepository.getConversations().listen((event) {
      add(ReceiveConversationEvent(event));
    });
  }
}
