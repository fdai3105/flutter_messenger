part of 'widgets.dart';

class ConversationTab extends StatelessWidget {
  final TabController tabController;

  const ConversationTab(this.tabController);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UI.paddingTop,
      color: UI.bodyBackground,
      child:
          BlocBuilder<RoomBloc, ConversationState>(builder: (context, state) {
        if (state is RoomSuccess) {
          if (state.list.isNotEmpty) {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.list.length,
                itemBuilder: (builder, index) {
                  return ConversationItem(state.list[index]);
                });
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                    "${Paths.assetIllustrations}/empty_conversation.png"),
                Text(
                  "No conversations, yet",
                  style: UI.textStyle
                      .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text("Lets start chatting with you contact."),
                const SizedBox(
                  height: 10,
                ),
                FlatButton(
                    onPressed: () {
                      tabController.animateTo(1);
                    },
                    child: Text(
                      "Chat people",
                      style: UI.textStyle.copyWith(
                          color: UI.primaryColor, fontWeight: FontWeight.w900),
                    )),
              ],
            );
          }
        } else if (state is ContactProgress) {
          return Container(
            height: 50,
            width: 50,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Container(
            height: 50,
            width: 50,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }),
    );
  }
}
