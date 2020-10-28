import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_chat/models/message.dart';
import 'package:flutter_bloc_chat/repositories/message_repository.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final MessageRepository messageRepository;
  String chatID;

  MessagesBloc(this.messageRepository) : super(MessagesInitial());

  @override
  Stream<MessagesState> mapEventToState(
    MessagesEvent event,
  ) async* {
    if (event is FetchMessagesEvent) {
      chatID = event.chatID;
      yield* _mapFetchMessagesEventToState(chatID);
    } else if (event is ReceiveMessagesEvent) {
      yield MessagesProgress();
      yield MessagesSuccess(event.messages);
    } else if (event is SendMessageEvent) {
      yield* _mapSendMessageEventToState(event.message, event.sendTo);
    }
  }

  Stream<MessagesState> _mapFetchMessagesEventToState(String chatID) async* {
    if(chatID != null) {
      messageRepository.getMessages(chatID).listen((event) {
        add(ReceiveMessagesEvent(event));
      });
    }
  }

  Stream<MessagesState> _mapSendMessageEventToState(
      Message message, String sendTo) async* {
    await messageRepository.sendMessage(chatID, message, sendTo);
  }
}
