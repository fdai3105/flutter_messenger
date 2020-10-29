part of "repositories.dart";

class ConversationRepository implements Repository {
  final _conversationProvider = ConversationProvider();

  Stream<List<Conversation>> getConversations() =>
      _conversationProvider.getConversations();

  @override
  void dispose() => _conversationProvider.dispose();
}
