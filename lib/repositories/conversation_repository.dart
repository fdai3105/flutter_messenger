import '../providers/conversation_provider.dart';

import '../models/conversation.dart';

class ConversationRepository {
  final _conversationProvider = ConversationProvider();

  Stream<List<Conversation>> getConversations() =>
      _conversationProvider.getConversations();
}
