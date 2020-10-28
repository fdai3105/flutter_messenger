import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter_bloc_chat/config/fields.dart';
import 'package:flutter_bloc_chat/config/paths.dart';
import '../models/user.dart';

class UserProvider {
  final FirebaseFirestore fireStore;

  UserProvider({FirebaseFirestore firestore})
      : fireStore = firestore ?? FirebaseFirestore.instance;

  Future<void> saveUserToFirestore(FirebaseAuth.User user) async {
    final ref = fireStore.collection(Paths.usersPath).doc(user.uid);
    final userExists = !await ref.snapshots().isEmpty;
    if (userExists) {
      await ref.set({Fields.userInfo: User.fromAuth(user).toMap()});
    }
  }

  Future<User> getUserByEmail(String email) async {
    var user;
    final ref = await fireStore
        .collection(Paths.usersPath)
        .where("userInfo.email", isEqualTo: email)
        .get();
    ref.docs.forEach((element) {
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
    final ref = await fireStore.collection(Paths.chatsPath).doc(chatID).get();
    final a = List<String>.from(ref.data()[Fields.chatFieldsMember]);
    for (var i = 0; i < a.length; i++) {
      final member = await getUserByEmail(a[i]);
      _members.add(member);
    }
    return _members;
  }
}
