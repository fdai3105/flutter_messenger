part of "providers.dart";

class UserProvider {
  final FirebaseFirestore fireStore;

  UserProvider({FirebaseFirestore firestore})
      : fireStore = firestore ?? FirebaseFirestore.instance;

  Future<void> saveUserToFirestore(fb_auth.User user) async {
    final ref = fireStore.collection(Paths.usersPath).doc(user.uid);
    final userExists = !await ref.snapshots().isEmpty;
    if (userExists) {
      await ref.set({Fields.userInfo: User.fromAuth(user).toMap()});
    }
  }

  Future<User> getUserByEmail(String email) async {
    var user;
    final doc = await fireStore
        .collection(Paths.usersPath)
        .where("userInfo.email", isEqualTo: email)
        .get();
    doc.docs.forEach((element) {
      if (element.data().isNotEmpty) {
        user = element.data()["userInfo"];
      }
    });
    if(user != null) {
      return User.fromMap(user);
    }
  }

  Future<List<User>> getMembersByChatID(String chatID) async {
    final _members = <User>[];
    final _doc = await fireStore.collection(Paths.chatsPath).doc(chatID).get();
    final _emailMembers = List<String>.from(_doc.data()[Fields.chatFieldsMember]);
    for (var i = 0; i < _emailMembers.length; i++) {
      final member = await getUserByEmail(_emailMembers[i]);
      _members.add(member);
    }
    return _members;
  }
}
