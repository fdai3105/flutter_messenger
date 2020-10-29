part of  '../blocs.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository _contactRepository;

  ContactBloc(this._contactRepository) : super(ContactInitial());

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is FetchContactEvent) {
      yield* _mapFetchContactEventToState();
    } else if (event is ReceiveContactEvent) {
      yield ContactProgress();
      print(event.contact);
      yield ContactSuccess(event.contact);
    } else if (event is AddContactEvent) {
      yield* _mapAddContactEventToState(event.email);
    }
  }

  Stream<ContactState> _mapFetchContactEventToState() async* {
    _contactRepository.getContacts(SharedPres.getUser().uID).listen((event) {
      add(ReceiveContactEvent(event));
    });
  }

  Stream<ContactState> _mapAddContactEventToState(String email) async* {
    await _contactRepository.addContact(email);
  }
}
