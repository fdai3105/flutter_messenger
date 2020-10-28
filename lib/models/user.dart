import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map[Fields.userFieldUID] = uID;
    map[Fields.userFieldName] = name;
    map[Fields.userFieldEmail] = email;
    map[Fields.userFieldAvatar] = avatar;
    return map;
  }

  // ignore: missing_return
  factory User.fromQuerySnapShot(QuerySnapshot querySnapshot,
      EventSink<List<User>> sink) {
    final users = <User>[];
    querySnapshot.docs.forEach((element) {
      users.add(User.fromMap(element.data()[Fields.contactInfo]));
    });
    sink.add(users);
  }

  @override
  String toString() {
    return 'User{uID: $uID, name: $name, email: $email, avatar: $avatar}';
  }
}
