import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_chat/models/user.dart';
import 'package:flutter_bloc_chat/providers/contact_provider.dart';

class ContactRepository implements ContactProvider {
  final ContactProvider _contactProvider = ContactProvider();

  @override
  Future<void> addContact(String email) => _contactProvider.addContact(email);

  @override
  Stream<List<User>> getContacts(String uID) =>
      _contactProvider.getContacts(uID);

  @override
  Future<void> removeContact(String email) =>
      _contactProvider.removeContact(email);

  @override
  Future<List<User>> findContacts(String email) =>
      _contactProvider.findContacts(email);
}
