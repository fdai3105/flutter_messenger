part of "providers.dart";

class UserProvider {
  final FirebaseFirestore _fireStore;

  UserProvider({FirebaseFirestore firestore})
      : _fireStore = firestore ?? FirebaseFirestore.instance;

  Future<void> saveUserToFirestore(fb_auth.User user) async {
    final ref = _fireStore.collection(Paths.usersPath).doc(user.uid);
    final isExists = await ref.get();
    if (!isExists.exists) {
      await ref.set(User.fromAuth(user).toMap());
    }
  }

  Future<void> setUserOnlineStatus({bool isOnline}) async {
    final _uid = SharedPres.getUser().uID;
    if (_uid != null) {
      try {
        final _doc = _fireStore.collection(Paths.usersPath).doc(_uid);
        await _doc.update({Fields.userIsOnline: isOnline});
      } on FirebaseException catch (e) {
        print(e.toString());
      }
    }
  }

  Future<User> getUserByEmail(String email) async {
    var user;
    final doc = await _fireStore
        .collection(Paths.usersPath)
        .where("email", isEqualTo: email)
        .get();
    doc.docs.forEach((element) {
      if (element.data().isNotEmpty) {
        user = element.data();
      }
    });
    if (user != null) {
      return User.fromMap(user);
    }
  }

  Future<User> getUserByUID(String uID) async {
    final ref = await _fireStore.collection(Paths.usersPath).doc(uID).get();
    if (ref.data() != null) {
      return User.fromMap(ref.data());
    } else {
      return null;
    }
  }

  Future<List<User>> getMembersByChatID(String chatID) async {
    final _members = <User>[];
    final _doc = await _fireStore.collection(Paths.chatsPath).doc(chatID).get();
    final _emailMembers = List<String>.from(_doc.data()[Fields.roomMember]);
    for (var i = 0; i < _emailMembers.length; i++) {
      final member = await getUserByEmail(_emailMembers[i]);
      _members.add(member);
    }
    return _members;
  }
}
