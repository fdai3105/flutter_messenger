part of "providers.dart";

class AuthProvider extends Provider {
  final fb_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthProvider({fb_auth.FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? fb_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ??
            GoogleSignIn(scopes: <String>[
              "email",
              "https://www.googleapis.com/auth/contacts.readonly"
            ]);

  Future<fb_auth.User> signIn(String email, String pas) {}

  Future<fb_auth.User> signInWithGoogle() async {
    final googleSignInAccount = await _googleSignIn.signIn();
    final googleSignInAuth = await googleSignInAccount.authentication;
    final authCredential = fb_auth.GoogleAuthProvider.credential(
      idToken: googleSignInAuth.idToken,
      accessToken: googleSignInAuth.accessToken,
    );
    await _firebaseAuth.signInWithCredential(authCredential);
    return _firebaseAuth.currentUser;
  }

  Future<bool> isLoggedIn() async {
    final user = _firebaseAuth.currentUser;
    return user != null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  void dispose() {}
}
