part of "providers.dart";


class ContactProvider implements Provider {
  final FirebaseFirestore _fireStore;

  StreamController<List<Contact>> _streamController;

  ContactProvider({FirebaseFirestore firestore})
      : _fireStore = firestore ?? FirebaseFirestore.instance;

  // add friend
  Future<void> addContact(String email) async {
    final user = await UserRepository().getUserByEmail(email);
    final currentUser = SharedPres.getUser();
    final isMe = email == currentUser.email;
    final contacts = await _getContacts(currentUser.uID);
    final alreadyAdd = contacts.any((element) => element.uID == user.uID);
    if (user != null && !isMe && !alreadyAdd) {
      final idConversation = user.uID.substring(0, user.uID.length ~/ 2) +
          currentUser.uID.substring(0, currentUser.uID.length ~/ 2);
      // add to current user
      await _fireStore
          .collection(Paths.usersPath)
          .doc(SharedPres.getUser().uID)
          .collection(Paths.contactsPath)
          .add({
        Fields.contactInfo: user.toMap(),
        Fields.contactCID: idConversation
      });
      // although all to yourself to contact
      await _fireStore
          .collection(Paths.usersPath)
          .doc(user.uID)
          .collection(Paths.contactsPath)
          .add({
        Fields.contactInfo: currentUser.toMap(),
        Fields.contactCID: idConversation
      });
      print("ContactProvider: add contact success");
    } else if (isMe) {
      print("ContactProvider: can't add yourself");
    } else if (alreadyAdd) {
      print("ContactProvider: already in you list contact");
    } else {
      print("ContactProvider: can't find and add contact");
    }
  }

  Future<List<Contact>> _getContacts(String uID) async {
    final _contacts = <Contact>[];
    final ref = await _fireStore
        .collection(Paths.usersPath)
        .doc(uID)
        .collection(Paths.contactsPath)
        .get();
    ref.docs.forEach((element) {
      final contact = element.data()[Fields.contactInfo];
      _contacts.add(Contact.fromMap(contact));
    });
    return _contacts;
  }

  Stream<List<Contact>> getContacts(String uID) {
    _streamController = StreamController()..sink;
    final ref = _fireStore
        .collection(Paths.usersPath)
        .doc(uID)
        .collection(Paths.contactsPath);
    return ref
        .snapshots()
        .transform(StreamTransformer<QuerySnapshot, List<Contact>>.fromHandlers(
          handleData: (snapshot, sink) =>
              Contact.fromQuerySnapShot(snapshot, sink),
        ));
  }

  Future<void> removeContact(String email) async {
    final ref = await _fireStore
        .collection(Paths.usersPath)
        .doc(SharedPres.getUser().uID)
        .collection(Paths.contactsPath)
        .where(Fields.contactEmail, isEqualTo: email)
        .get();
  }

  Future<List<Contact>> findContacts(String email) async {
    if (email != SharedPres.getUser().email && !await _isInContact(email)) {
      final _contacts = <Contact>[];
      final ref = await _fireStore
          .collection(Paths.usersPath)
          .where("${Fields.userInfo}.${Fields.userFieldEmail}",
              isEqualTo: email)
          .get();
      ref.docs.forEach((element) {
        _contacts.add(Contact.fromUser(element.data()));
      });
      return _contacts;
    }
    return [];
  }

  Future<bool> _isInContact(String email) async {
    final ref = await _fireStore
        .collection(Paths.usersPath)
        .doc(SharedPres.getUser().uID)
        .collection(Paths.contactsPath)
        .where("${Fields.contactInfo}.${Fields.contactEmail}", isEqualTo: email)
        .get();
    if (ref.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
