part of 'widgets.dart';

class ChatInputField extends StatelessWidget {
  final String cID;
  final String sendTo;

  final _editingController = TextEditingController();

  ChatInputField({Key key, @required this.cID, @required this.sendTo})
      : super(key: key);

  void sendMessage(BuildContext context, String text) {
    context.bloc<MessagesBloc>().add(SendMessageEvent(cID, text, sendTo));
    _editingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _editingController,
                decoration: UI.textDecoration.copyWith(
                    hintText: "Type a message",
                    hintStyle: const TextStyle(fontSize: 16)),
              ),
            ),
            IconButton(
              onPressed: () {
                final _text = _editingController.text;
                if (_text.isNotEmpty) {
                  sendMessage(context, _text);
                }
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }
}
