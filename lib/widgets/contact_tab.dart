part of 'widgets.dart';

class ContactTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UI.paddingTop,
      color: UI.bodyBackground,
      child: BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
        if (state is ContactSuccess) {
          if (state.contacts.isNotEmpty) {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // TODO(fidai): here
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      cID: state.contacts[index].cID,
                                      member: state.contacts[index],
                                    )));
                      },
                      child: ListTile(
                        leading: ClipOval(
                          child: Image.network(state.contacts[index].avatar),
                        ),
                        title: Text(state.contacts[index].name),
                        subtitle: Text(state.contacts[index].email),
                      ),
                    ),
                  );
                });
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("${Paths.assetIllustrations}/empty_contact.png"),
                Text(
                  "You have no contact :(",
                  style: UI.textStyle
                      .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text("Let's find some friend."),
                const SizedBox(
                  height: 10,
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.findContact);
                    },
                    child: Text(
                      "Find friends",
                      style: UI.textStyle.copyWith(
                          color: UI.primaryColor, fontWeight: FontWeight.w900),
                    )),
              ],
            );
          }
        } else if (state is ContactProgress) {
          return Container(
              height: 50, width: 50, child: const CircularProgressIndicator());
        } else if (state is ContactFail) {
          return const Text("Contact fail");
        } else {
          return Center(
            child: Container(
                height: 50, width: 50, child: const CircularProgressIndicator()),
          );
        }
      }),
    );
  }
}
