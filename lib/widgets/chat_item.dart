part of "widgets.dart";

class ChatItem extends StatelessWidget {
  final Message message;

  const ChatItem({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisAlignment: message.isSelf
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          if (!message.isSelf)
            ClipOval(
              child: Image.network(message.senderAvatar, height: 30),
            ),
          const SizedBox(
            width: 4,
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
                color: message.isSelf ? UI.primaryColor : Colors.black12,
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              message.text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: message.isSelf ? Colors.white : UI.textColor),
            ),
          ),
        ],
      ),
    );
  }
}
