part of 'widgets.dart';

class ConversationItem extends StatelessWidget {
  final Conversation _conversation;

  const ConversationItem(this._conversation);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      chatID: _conversation.chatId,
                      runFromHome: true,
                      sendTo: _conversation.members.last,
                    ))),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/images/place_holder/image-placeholder.jpg",
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_conversation.members.length > 1
                      ? _conversation.members.first
                      : "${_conversation.members.first}"),
                  Text(_conversation.latestMessage.text),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
