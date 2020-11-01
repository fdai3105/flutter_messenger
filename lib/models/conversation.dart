part of 'models.dart';

class Conversation {
  final String chatId;
  final Message latestMessage;
  final String user;
  final List<Contact> members;

  Conversation({this.chatId, this.latestMessage, this.user, this.members});

  factory Conversation.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data();
    final _members = <Contact>[];
    final members = <Contact>[];

    final selfEmail = SharedPres.getUser().email;
    final Map memberMap = data[Fields.chatMemberInfo];
    memberMap.forEach((key, value) {
      members.add(Contact.fromMap(value));
    });
    for (var i = 0; i < members.length; i++) {
      if (members[i].email != selfEmail) {
        _members.add(members[i]);
      }
    }
    return Conversation(
        chatId: doc.id,
        latestMessage:
            Message.fromMap(Map.from(data[Fields.chatsLastMessage])),
        user: selfEmail,
        members: _members);
  }

  // ignore: missing_return
  factory Conversation.fromQuerySnapShot(
      QuerySnapshot querySnapshot, EventSink<List<Conversation>> sink) {
    final conversations = <Conversation>[];
    querySnapshot.docs.forEach((document) {
      conversations.add(Conversation.fromFireStore(document));
    });
    sink.add(conversations);
  }

  @override
  String toString() {
    return 'Conversation{chatId: $chatId, latestMessage: $latestMessage, user: $user, members: $members}';
  }
}
