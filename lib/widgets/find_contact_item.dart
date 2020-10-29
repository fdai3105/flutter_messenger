part of 'widgets.dart';

class FindContactItem extends StatelessWidget {
  final Contact contact;

  const FindContactItem({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: Image.network(
          contact.avatar,
        ),
      ),
      title: Text(contact.name),
      subtitle: Text(contact.email),
      trailing: FlatButton(
          onPressed: () {
            context.bloc<ContactBloc>().add(AddContactEvent(contact.email));
            Navigator.pop(context);
          },
          color: Colors.blueAccent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
