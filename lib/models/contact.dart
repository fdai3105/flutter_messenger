part of 'models.dart';

class Contact {
  String uID;
  String cID;
  String name;
  String email;
  String avatar;

  Contact(this.uID, this.cID, this.name, this.email, this.avatar);

  factory Contact.fromMap(Map map) {
    return Contact(map[Fields.userFieldUID], null, map[Fields.contactName],
        map[Fields.contactEmail], map[Fields.contactAvatar]);
  }

  factory Contact.fromUser(Map map) {
    final _user = User.fromMap(map[Fields.userInfo]);
    return Contact(_user.uID, null, _user.name, _user.email, _user.avatar);
  }

  // ignore: missing_return
  factory Contact.fromQuerySnapShot(
      QuerySnapshot snapshot, EventSink<List<Contact>> sink) {
    final contacts = <Contact>[];
    snapshot.docs.forEach((element) {
      final _cID = element.data()[Fields.contactCID];
      final _contact = element.data()[Fields.contactInfo];
      print("here: $_contact");
      contacts.add(Contact(
          _contact[Fields.contactID],
          _cID,
          _contact[Fields.contactName],
          _contact[Fields.contactEmail],
          _contact[Fields.contactAvatar]));
    });
    sink.add(contacts);
  }

  @override
  String toString() {
    return 'Contact{uID: $uID, conversationID: $cID, name: $name, email: $email, avatar: $avatar}';
  }
}
