part of 'models.dart';

class User {
  String uID;
  String name;
  String email;
  String avatar;
  bool isOnline;

  User({this.uID, this.name, this.email, this.avatar, this.isOnline});

  factory User.fromAuth(firebase_auth.User userAuth) {
    return User(
        uID: userAuth.uid,
        name: userAuth.displayName,
        email: userAuth.email,
        avatar: userAuth.photoURL,
        isOnline: true);
  }

  factory User.fromMap(Map map) {
    return User(
        uID: map[Fields.userUID],
        name: map[Fields.userName],
        email: map[Fields.userEmail],
        avatar: map[Fields.userAvatar],
        isOnline: map[Fields.userIsOnline]);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map[Fields.userUID] = uID;
    map[Fields.userName] = name;
    map[Fields.userEmail] = email;
    map[Fields.userAvatar] = avatar;
    map[Fields.userIsOnline] = isOnline;
    return map;
  }

  @override
  String toString() {
    return 'User{uID: $uID, name: $name, email: $email, avatar: $avatar, isOnline: $isOnline}';
  }
}
