part of "providers.dart";

class ContactProvider implements Provider {
  final FirebaseFirestore _fireStore;

  StreamController<List<Contact>> _streamController;

  ContactProvider({FirebaseFirestore firestore})
      : _fireStore = firestore ?? FirebaseFirestore.instance;

  // add friend
  Future<void> addContact(String email) async {
    final _user = await UserRepository().getUserByEmail(email);
    final _currentUser = SharedPres.getUser();
    final _isMySelf = email == _currentUser.email;
    final _contacts = await _getAllContact(_currentUser.uID);
    final isAdded = _contacts.any((element) => element == _user.uID);
    if (_user != null && !_isMySelf && !isAdded) {
      try {
        final idConversation = _user.uID.substring(0, _user.uID.length ~/ 2) +
            _currentUser.uID.substring(0, _currentUser.uID.length ~/ 2);
        // add to current user
        await _fireStore
            .collection(Paths.usersPath)
            .doc(SharedPres.getUser().uID)
            .collection(Paths.contactsPath)
            .add({
          Fields.contactID: _user.uID,
          Fields.contactCID: idConversation
        });
        // although all to yourself to contact
        await _fireStore
            .collection(Paths.usersPath)
            .doc(_user.uID)
            .collection(Paths.contactsPath)
            .add({
          Fields.contactID: _currentUser.uID,
          Fields.contactCID: idConversation
        });
        print("ContactProvider: add contact success");
      } on FirebaseException catch (e) {
        print('addContact: error code ${e.code}');
        print(e.message);
      }
    } else if (_isMySelf) {
      print("addContact: can't add yourself");
    } else if (isAdded) {
      print("addContact: already in you list contact");
    } else {
      print("addContact: can't find and add contact");
    }
  }

  // get all contact in user
  Future<List<String>> _getAllContact(String uID) async {
    final _contactsUID = <String>[];
    final ref = await _fireStore
        .collection(Paths.usersPath)
        .doc(uID)
        .collection(Paths.contactsPath)
        .get();
    for (final i in ref.docs) {
      _contactsUID.add(i.data()[Fields.contactID]);
    }
    return _contactsUID;
  }

  // get and display in UI
  Stream<Map<String, String>> getContacts(String uID) {
    _streamController = StreamController()..sink;
    final ref = _fireStore
        .collection(Paths.usersPath)
        .doc(uID)
        .collection(Paths.contactsPath);
    return ref.snapshots().transform(
            StreamTransformer<QuerySnapshot, Map<String, String>>.fromHandlers(
          handleData: (snapshot, sink) =>
              Contact.fromQuerySnapShot(snapshot, sink),
        ));
  }

  Future<void> removeContact(String email) async {
    // final ref = await _fireStore
    //     .collection(Paths.usersPath)
    //     .doc(SharedPres.getUser().uID)
    //     .collection(Paths.contactsPath)
    //     .where(Fields.contactEmail, isEqualTo: email)
    //     .get();
  }

  Future<User> _findUserByEmail(String email) async {
    final ref = await _fireStore
        .collection(Paths.usersPath)
        .where(Fields.userEmail, isEqualTo: email)
        .get();
    if (ref.docs.isNotEmpty) {
      return User.fromMap(ref.docs[0].data());
    } else {
      return null;
    }
  }

  // use in find contact page
  Future<List<Contact>> findContact(String email) async {
    final contact = await _findUserByEmail(email);
    final _isAdded = await isAdded(contact.uID);
    if (contact.email != SharedPres.getUser().email && !_isAdded) {
      final _contacts = <Contact>[];
      final ref = await _fireStore
          .collection(Paths.usersPath)
          .where(Fields.userEmail, isEqualTo: email)
          .get();
      ref.docs.forEach((element) {
        _contacts.add(Contact.fromUser(element.data()));
      });
      return _contacts;
    }
    return null;
  }

  Future<bool> isAdded(String uID) async {
    final _currentUser = SharedPres.getUser();
    final _contacts = await _getAllContact(_currentUser.uID);
    final isAdded = _contacts.any((element) => element == uID);
    return isAdded;
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
