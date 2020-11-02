part of "providers.dart";

class MessageProvider extends Provider {
  final FirebaseFirestore fireStore;

  StreamController<List<Message>> _streamController;

  MessageProvider({FirebaseFirestore fireStore})
      : fireStore = fireStore ?? FirebaseFirestore.instance;

  Stream<List<Message>> getMessages(String chatID) {
    _streamController = StreamController();
    _streamController.sink;
    final doc = fireStore.collection(Paths.chatsPath).doc(chatID);
    final messages = doc
        .collection(Paths.messagesPath)
        .orderBy(Fields.romTime, descending: true);
    return messages.snapshots().transform(
        StreamTransformer<QuerySnapshot, List<Message>>.fromHandlers(
            handleData: (snapshot, sink) =>
                Message.fromQuerySnapShot(snapshot, sink)));
  }

  Future<List<Message>> getPreviousMessages(
      String chatId, Message prevMessage) {}

  Future<void> sendMessage(
      String chatId, Message message, String sendTo) async {
    final chatDocRef = fireStore.collection(Paths.chatsPath).doc(chatId);
    final messagesCollection = chatDocRef.collection(Paths.messagesPath);
    await messagesCollection.add(message.toMap());
    // find info two member
    final ref = await chatDocRef.get();
    if (ref.exists) {
      await chatDocRef.update({
        Fields.roomLastMessage: LastMessage(
                text: message.text,
                sendName: message.senderName,
                time: message.timeStamp)
            .toMap(),
        Fields.roomMember: [message.senderEmail, sendTo],
      });
    } else {
      final members1 =
          await UserRepository().getUserByEmail(message.senderEmail);
      final members2 = await UserRepository().getUserByEmail(sendTo);
      await chatDocRef.set({
        Fields.roomLastMessage: LastMessage(
                text: message.text,
                sendName: message.senderName,
                time: message.timeStamp)
            .toMap(),
        Fields.roomMember: [message.senderEmail, sendTo],
        Fields.roomMemberInfo: {"0": members1.toMap(), "1": members2.toMap()}
      });
    }
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
