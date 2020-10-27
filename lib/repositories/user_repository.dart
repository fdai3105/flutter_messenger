import 'package:firebase_auth/firebase_auth.dart' as FirebaseUser;
import 'package:flutter_bloc_chat/models/user.dart';
import 'package:flutter_bloc_chat/providers/user_provider.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();

  void saveUserToFirestore(FirebaseUser.User user) =>
      _userProvider.saveUserToFirestore(user);

  Future<List<User>> getMembersByChatID(String chatID) =>
      _userProvider.getMembersByChatID(chatID);
}
