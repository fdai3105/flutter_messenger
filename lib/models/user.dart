import 'package:firebase_auth/firebase_auth.dart' as UserAuth;
import 'package:flutter_bloc_chat/config/fields.dart';

class User {
  String uID;
  String name;
  String email;
  String avatar;

  User({this.uID, this.name, this.email, this.avatar});

  factory User.fromAuth(UserAuth.User userAuth) {
    return User(
        uID: userAuth.uid,
        name: userAuth.displayName,
        email: userAuth.email,
        avatar: userAuth.photoURL);
  }

  factory User.fromMap(Map map) {
    return User(
        uID: map[Fields.userFieldUID],
        name: map[Fields.userFieldName],
        email: map[Fields.userFieldEmail],
        avatar: map[Fields.userFieldAvatar]);
  }

  Map<String, dynamic> toMap(User user) {
    final map = <String, dynamic>{};
    map[Fields.userFieldUID] = user.uID;
    map[Fields.userFieldName] = user.name;
    map[Fields.userFieldEmail] = user.email;
    map[Fields.userFieldAvatar] = user.avatar;
    return map;
  }

  @override
  String toString() {
    return 'User{uID: $uID, name: $name, email: $email, avatar: $avatar}';
  }
}
