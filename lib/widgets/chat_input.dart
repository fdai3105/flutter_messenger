part of 'widgets.dart';
class ChatInputField extends StatelessWidget {
  final String cID;
  final String sendTo;

  final _editingController = TextEditingController();

  ChatInputField({Key key, @required this.cID, @required this.sendTo})
      : super(key: key);

  void sendMessage(BuildContext context, String text) {
    final message = Message(
        text: text,
        timeStamp: DateTime
            .now()
            .millisecondsSinceEpoch,
        senderName: SharedPres
            .getUser()
            .name,
        senderEmail: SharedPres
            .getUser()
            .email);
    context
        .bloc<MessagesBloc>()
        .add(SendMessageEvent(cID, text, sendTo));
    _editingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.insert_emoticon,
                color: Colors.black.withOpacity(0.8),
              ),
              onPressed: () {}),
          Expanded(
            child: TextField(
              controller: _editingController,
              decoration: InputDecoration(
                  fillColor: Colors.black,
                  hintText: "Type a message",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    color: Colors.black.withOpacity(0.8),
                    onPressed: () {
                      final _text = _editingController.text;
                      if (_text.isNotEmpty) {
                        sendMessage(context, _text);
                      }
                    },
                  ),
                  focusedBorder: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
