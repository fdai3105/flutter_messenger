part of 'widgets.dart';

class ContactTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
      if (state is ContactSuccess) {
        print(state.contacts);
        return ListView.builder(
            itemCount: state.contacts.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  final createConversationID =
                      "${SharedPres.getUser().email}+${state.contacts[index].email}";
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatPage(
                                chatID: createConversationID,
                                runFromHome: false,
                                sendTo: state.contacts[index].email,
                              )));
                },
                child: ListTile(
                  title: Text(state.contacts[index].name),
                  subtitle: Text(state.contacts[index].email),
                ),
              );
            });
      } else if (state is ContactProgress) {
        return const CircularProgressIndicator();
      } else if (state is ContactFail) {
        return const Text("Contact fail");
      } else {
        return const Text("Contact state unknow");
      }
    });
  }
}
