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
        .orderBy(Fields.chatFieldsTime, descending: true);
    return messages.snapshots().transform(
        StreamTransformer<QuerySnapshot, List<Message>>.fromHandlers(
            handleData: (snapshot, sink) =>
                Message.fromQuerySnapShot(snapshot, sink)));
  }

  void getMessagess(String chatID) async {
    final doc = fireStore.collection(Paths.chatsPath);
    final messages = await doc
        .where(Fields.chatFieldsMember,
            arrayContains: '["hoangphidai123@gmai.com", "fdai3105@gmail.com"]')
        .get();

    messages.docs.forEach((element) {
      print(element.data());
    });
  }

  Future<List<Message>> getPreviousMessages(
      String chatId, Message prevMessage) {}

  Future<void> sendMessage(
      String chatId, Message message, String sendTo) async {
    final chatDocRef = fireStore.collection(Paths.chatsPath).doc(chatId);
    final messagesCollection = chatDocRef.collection(Paths.messagesPath);
    await messagesCollection.add(message.toMap());

    // find info two member
    final members1 = await UserRepository().getUserByEmail(message.senderEmail);
    final members2 = await UserRepository().getUserByEmail(sendTo);
    await chatDocRef.set({
      Fields.chatFieldsLastMessage: message.toMap(),
      Fields.chatFieldsMember: [message.senderEmail, sendTo],
      Fields.chatFieldsMemberInfo: {
        "0": members1.toMap(),
        "1": members2.toMap()
      }
    });
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
