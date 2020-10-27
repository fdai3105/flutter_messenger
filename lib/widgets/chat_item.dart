import 'package:flutter/material.dart';
import 'package:flutter_bloc_chat/models/message.dart';

class ChatItem extends StatelessWidget {
  final Message message;

  const ChatItem({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment:
            message.isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: message.isSelf
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15, left: 15, bottom: 2),
                child: Text(
                  message.senderEmail,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  message.text,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
