import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/models.dart';
import '../providers/providers.dart';

part "auth_repository.dart";

part 'contact_repository.dart';

part 'room_repository.dart';

part 'message_repository.dart';

part 'user_repository.dart';

abstract class Repository {
  Repository();

  void dispose();
}

abstract class IAuthRepository implements Repository {
  Future<User> login();

  Future<firebase_auth.User> loginWithGoogle();

  Future<bool> isLoggedIn();

  Future<void> signOut();
}

abstract class IContactRepository implements Repository {}

abstract class IConversationRepository implements Repository {}

abstract class IMessageRepository implements Repository {}

abstract class IUserRepository implements Repository {}
