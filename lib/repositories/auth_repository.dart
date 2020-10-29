part of "repositories.dart";

class AuthRepository implements IAuthRepository {
  AuthProvider authProvider = AuthProvider();

  @override
  Future<User> login() {
    throw UnimplementedError();
  }

  @override
  Future<firebase_auth.User> loginWithGoogle() =>
      authProvider.signInWithGoogle();

  @override
  Future<bool> isLoggedIn() => authProvider.isLoggedIn();

  @override
  Future<void> signOut() => authProvider.signOut();

  @override
  void dispose() {}
}
