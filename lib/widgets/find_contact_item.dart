part of 'widgets.dart';

class FindContactItem extends StatelessWidget {
  final User user;

  const FindContactItem({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: Image.network(
          user.avatar,
        ),
      ),
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: FlatButton(
          onPressed: () {
            context.bloc<ContactBloc>().add(AddContactEvent(user.email));
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
