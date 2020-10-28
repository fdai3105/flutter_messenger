import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_chat/config/fields.dart';
import 'package:flutter_bloc_chat/config/paths.dart';
import 'package:flutter_bloc_chat/models/user.dart';
import 'package:flutter_bloc_chat/repositories/user_repository.dart';
import 'package:flutter_bloc_chat/utils/shared_pres.dart';

class ContactProvider {
  final FirebaseFirestore _fireStore;

  StreamController<List<User>> _streamController;

  ContactProvider({FirebaseFirestore firestore})
      : _fireStore = firestore ?? FirebaseFirestore.instance;

  Future<void> addContact(String email) async {
    final user = await UserRepository().getUserByEmail(email);
    final currentUser = SharedPres.getUser();
    final isMe = email == currentUser.email;
    final contacts = await _getContacts(currentUser.uID);
    final alreadyAdd = contacts.any((element) => element.uID == user.uID);
    if (user != null && !isMe && !alreadyAdd) {
      await _fireStore
          .collection(Paths.usersPath)
          .doc(SharedPres.getUser().uID)
          .collection(Paths.contactsPath)
          .add({Fields.contactInfo: user.toMap()});
      await _fireStore
          .collection(Paths.usersPath)
          .doc(user.uID)
          .collection(Paths.contactsPath)
          .add({Fields.contactInfo: currentUser.toMap()});
      print("ContactProvider: add contact success");
    } else if (isMe) {
      print("ContactProvider: can't add yourself");
    } else if (alreadyAdd) {
      print("ContactProvider: already in you list contact");
    } else {
      print("ContactProvider: can't find and add contact");
    }
  }

  Future<List<User>> _getContacts(String uID) async {
    final _contacts = <User>[];
    final ref = await _fireStore
        .collection(Paths.usersPath)
        .doc(uID)
        .collection(Paths.contactsPath)
        .get();
    ref.docs.forEach((element) {
      final contact = element.data()[Fields.contactInfo];
      _contacts.add(User.fromMap(contact));
    });
    return _contacts;
  }

  Stream<List<User>> getContacts(String uID) {
    _streamController = StreamController();
    _streamController.sink;
    final ref = _fireStore
        .collection(Paths.usersPath)
        .doc(uID)
        .collection(Paths.contactsPath);
    return ref
        .snapshots()
        .transform(StreamTransformer<QuerySnapshot, List<User>>.fromHandlers(
          handleData: (snapshot, sink) =>
              User.fromQuerySnapShot(snapshot, sink),
        ));
  }

  Future<void> removeContact(String email) async {
    final ref = await _fireStore
        .collection(Paths.usersPath)
        .doc(SharedPres.getUser().uID)
        .collection(Paths.contactsPath)
        .where(Fields.contactEmail, isEqualTo: email)
        .get();
    print(ref.docs);
  }

  Future<List<User>> findContacts(String email) async {
    if (email != SharedPres.getUser().email && !await _isInContact(email)) {
      final _contacts = <User>[];
      final ref = await _fireStore
          .collection(Paths.usersPath)
          .where("${Fields.userInfo}.${Fields.userFieldEmail}",
              isEqualTo: email)
          .get();
      ref.docs.forEach((element) {
        print(element.data()[Fields.userInfo]);
        _contacts.add(User.fromMap(element.data()[Fields.userInfo]));
      });
      return _contacts;
    }
    return [];
  }

  Future<bool> _isInContact(String email) async {
    final ref = await _fireStore
        .collection(Paths.usersPath)
        .doc(SharedPres.getUser().uID)
        .collection(Paths.contactsPath)
        .where("${Fields.contactInfo}.${Fields.contactEmail}", isEqualTo: email)
        .get();
    if (ref.docs.length > 0) {
      return true;
    } else {
      return false;
    }
  }
}
