part of "repositories.dart";

class UserRepository implements UserProvider {
  final UserProvider _userProvider = UserProvider();

  @override
  FirebaseFirestore get _fireStore => throw UnimplementedError();

  @override
  Future<List<User>> getMembersByChatID(String chatID) =>
      _userProvider.getMembersByChatID(chatID);

  @override
  Future<User> getUserByEmail(String email) =>
      _userProvider.getUserByEmail(email);

  @override
  Future<void> saveUserToFirestore(firebase_auth.User user) =>
      _userProvider.saveUserToFirestore(user);

  @override
  Future<User> getUserByUID(String uID) => _userProvider.getUserByUID(uID);
}
