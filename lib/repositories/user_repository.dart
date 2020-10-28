import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import '../models/user.dart';
import '../providers/user_provider.dart';

class UserRepository implements UserProvider {
  final UserProvider _userProvider = UserProvider();

  @override
  FirebaseFirestore get fireStore => throw UnimplementedError();

  @override
  Future<List<User>> getMembersByChatID(String chatID) =>
      _userProvider.getMembersByChatID(chatID);

  @override
  Future<User> getUserByEmail(String email) =>
      _userProvider.getUserByEmail(email);

  @override
  Future<void> saveUserToFirestore(FirebaseUser.User user) =>
      _userProvider.saveUserToFirestore(user);
}
