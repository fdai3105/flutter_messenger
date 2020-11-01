part of '../blocs.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository _contactRepository;

  ContactBloc(this._contactRepository) : super(ContactInitial());

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is FetchContactEvent) {
      yield* _mapFetchContactEventToState();
    } else if (event is ReceiveContactEvent) {
      yield ContactProgress();
      yield ContactSuccess(event.contact);
    } else if (event is AddContactEvent) {
      yield* _mapAddContactEventToState(event.email);
    }
  }

  Stream<ContactState> _mapFetchContactEventToState() async* {
    _contactRepository.getContacts(SharedPres.getUser().uID).listen((event) {
      final _contacts = <Contact>[];
      var _user;
      var _cID;
      event.forEach((key, value) async {
        if (key == Fields.contactID) {
          _user = await UserRepository().getUserByUID(value);
        } else if (key == Fields.contactCID) {
          _cID = value;
        }
        if (_user != null) {
          _contacts.add(
              Contact(_user.uID, _cID, _user.name, _user.email, _user.avatar));
          add(ReceiveContactEvent(_contacts));
        }
      });
      add(ReceiveContactEvent(_contacts));
    });
  }

  Stream<ContactState> _mapAddContactEventToState(String email) async* {
    await _contactRepository.addContact(email);
  }
}
