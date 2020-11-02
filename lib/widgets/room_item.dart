part of 'widgets.dart';

class ConversationItem extends StatelessWidget {
  final Room _conversation;

  const ConversationItem(this._conversation);

  @override
  Widget build(BuildContext context) {
    final _findTheMember = _conversation.members
        .where((element) => element.uID != SharedPres.getUser().uID).toList();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      cID: _conversation.chatId,
                      member: _conversation.members.first,
                    ))),
        child: ListTile(
            leading: ClipOval(
              child: Image.network(
                _findTheMember.first.avatar,
                height: 50,
                width: 50,
              ),
            ),
            title: Text(_findTheMember.first.name),
            subtitle: RichText(
              text: TextSpan(style: UI.textStyle, children: [
                TextSpan(
                    text: _conversation.latestMessage.sendName ==
                            SharedPres.getUser().name
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
