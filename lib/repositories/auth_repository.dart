import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc_chat/utils/shared_pres.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';

import 'base_repository.dart';

class AuthRepository extends BaseRepository {
  AuthProvider authProvider = AuthProvider();

  Future<User> loginWithGoogle() => authProvider.signInWithGoogle();

  Future<bool> isLoggedIn() => authProvider.isLoggedIn();

  Future<void> signOut() => authProvider.signOut();

  @override
  void dispose() {}
}
