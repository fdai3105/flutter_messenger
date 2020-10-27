import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_chat/repositories/conversation_repository.dart';
import '../../providers/conversation_provider.dart';
import '../../models/conversation.dart';

part 'conversation_event.dart';

part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository conversationRepository;

  ConversationBloc(this.conversationRepository) : super(ConversationInitial());

  @override
  Stream<ConversationState> mapEventToState(ConversationEvent event) async* {
    if (event is FetchConversationEvent) {
      yield* _mapFetchConversationEventToState();
    } else if(event is ReceiveConversationEvent) {
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
