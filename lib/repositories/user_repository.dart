part of "repositories.dart";

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
  Future<void> saveUserToFirestore(firebase_auth.User user) =>
      _userProvider.saveUserToFirestore(user);
}
