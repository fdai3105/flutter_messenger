part of "repositories.dart";

class RoomRepository implements Repository {
  final _conversationProvider = RoomProvider();

  Stream<List<Room>> getConversations() =>
      _conversationProvider.getConversations();

  @override
  void dispose() => _conversationProvider.dispose();
}
