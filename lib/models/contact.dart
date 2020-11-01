part of 'models.dart';

class Contact {
  String uID;
  String cID;
  String name;
  String email;
  String avatar;

  Contact(this.uID, this.cID, this.name, this.email, this.avatar);

  factory Contact.fromMap(Map map) {
    return Contact(map[Fields.userUID], null, map[Fields.contactName],
        map[Fields.contactEmail], map[Fields.contactAvatar]);
  }

  factory Contact.fromUser(Map map) {
    final _user = User.fromMap(map);
    return Contact(_user.uID, null, _user.name, _user.email, _user.avatar);
  }

  // ignore: missing_return
  factory Contact.fromQuerySnapShot(
      QuerySnapshot snapshot, EventSink<Map<String, String>> sink) {
    final contacts = <String, String>{};
    snapshot.docs.forEach((element) {
      final _cID = element.data()[Fields.contactCID];
      final _uID = element.data()[Fields.contactID];
      contacts.addAll({Fields.contactID: _uID, Fields.contactCID: _cID});
    });
    sink.add(contacts);
  }

  @override
  String toString() {
    return 'Contact{uID: $uID, conversationID: $cID, name: $name, email: $email, avatar: $avatar}';
  }
}
