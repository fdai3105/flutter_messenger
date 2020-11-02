part of "providers.dart";

class RoomProvider extends Provider {
  final FirebaseFirestore _fireStore;

  final _streamController = StreamController<List<Room>>()..sink;

  RoomProvider({FirebaseFirestore fireStore})
      : _fireStore = fireStore ?? FirebaseFirestore.instance;

  Stream<List<Room>> getConversations() {
    final currentEmail = SharedPres.getUser().email;
    return _fireStore
        .collection(Paths.chatsPath)
        .where(Fields.roomMember, arrayContains: currentEmail)
        .orderBy("lastMessage.time", descending: true)
        .snapshots()
        .transform(StreamTransformer<QuerySnapshot, List<Room>>.fromHandlers(
          handleData: _mapDocToRoom,
        ));
  }

  Future<void> _mapDocToRoom(
      QuerySnapshot snapshot, EventSink<List<Room>> sink) async {
    final _rooms = <Room>[];
    for (final i in snapshot.docs) {
      final _lastMessMap = i.data()[Fields.roomLastMessage];
      final _lastMes = LastMessage(
          text: _lastMessMap[Fields.romText],
          sendName: _lastMessMap[Fields.roomSenderName],
          time: _lastMessMap[Fields.romTime]);

      final _members = <Contact>[];
      final _listMember = List.from(i.data()[Fields.roomMember]);
      for (final i in _listMember) {
        final _user = await UserRepository().getUserByEmail(i);
        _members.add(Contact(_user.uID, null, _user.name, _user.email,
            _user.avatar, _user.isOnline));
      }
      _rooms.add(Room(
        chatId: i.id,
        latestMessage: _lastMes,
        members: _members,
      ));
    }
    sink.add(_rooms);
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
