import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthProvider({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ??
            GoogleSignIn(scopes: <String>[
              "email",
              "https://www.googleapis.com/auth/contacts.readonly"
            ]);

  Future<User> singIn(String email, String pas) {}

  Future<User> signInWithGoogle() async {
    final googleSignInAccount = await _googleSignIn.signIn();
    final googleSignInAuth = await googleSignInAccount.authentication;
    final authCredential = GoogleAuthProvider.credential(
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
}
