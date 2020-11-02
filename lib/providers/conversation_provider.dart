part of "providers.dart";

class ConversationProvider extends Provider {
  final FirebaseFirestore fireStore;

  StreamController<List<Conversation>> _streamController;

  ConversationProvider({FirebaseFirestore fireStore})
      : fireStore = fireStore ?? FirebaseFirestore.instance;

  Stream<List<Conversation>> getConversations() {
    _streamController = StreamController()..sink;
    final currentEmail = SharedPres.getUser().email;
    return fireStore
        .collection(Paths.chatsPath)
        .where(Fields.roomMember, arrayContains: currentEmail)
        .orderBy("lastMessage.time", descending: true)
        .snapshots()
        .transform(
            StreamTransformer<QuerySnapshot, List<Conversation>>.fromHandlers(
                handleData: (data, sink) =>
                    Conversation.fromQuerySnapShot(data, sink)));
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
