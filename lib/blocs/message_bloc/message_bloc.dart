part of '../blocs.dart';

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
      yield* _mapSendMessageEventToState(event.text, event.sendTo);
    }
  }

  Stream<MessagesState> _mapFetchMessagesEventToState(String chatID) async* {
    messageRepository.getMessages(chatID).listen((event) {
      add(ReceiveMessagesEvent(event));
    });
  }

  Stream<MessagesState> _mapSendMessageEventToState(
      String text, String sendTo) async* {
    final message = Message(
        text: text,
        timeStamp: DateTime.now().millisecondsSinceEpoch,
        senderName: SharedPres.getUser().name,
        senderEmail: SharedPres.getUser().email);
    await messageRepository.sendMessage(chatID, message, sendTo);
  }
}
