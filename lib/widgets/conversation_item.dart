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
                      cID: _conversation.chatId,
                      member: _conversation.members.last,
                    ))),
        child: ListTile(
            leading: ClipOval(
              child: Image.network(
                _conversation.members.first.avatar,
                height: 50,
                width: 50,
              ),
            ),
            title: Text(_conversation.members.first.name),
            subtitle: RichText(
              text: TextSpan(style: UI.textStyle, children: [
                TextSpan(
                    text: _conversation.latestMessage.sendName == SharedPres.getUser().name
                        ? "You: ${_conversation.latestMessage.text}"
                        : _conversation.latestMessage.text),
                const TextSpan(text: " - "),
                TextSpan(
                    text: CustomDateTime.customDateTime(
                        _conversation.latestMessage.time)),
              ]),
            )),
      ),
    );
  }
}
