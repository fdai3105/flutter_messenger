part of "repositories.dart";

class ContactRepository implements Repository {
  final ContactProvider _contactProvider = ContactProvider();

  Future<void> addContact(String email) => _contactProvider.addContact(email);

  Stream<List<Contact>> getContacts(String uID) =>
      _contactProvider.getContacts(uID);

  Future<void> removeContact(String email) =>
      _contactProvider.removeContact(email);

  Future<List<Contact>> findContacts(String email) =>
      _contactProvider.findContacts(email);

  void dispose() => _contactProvider.dispose();
}
