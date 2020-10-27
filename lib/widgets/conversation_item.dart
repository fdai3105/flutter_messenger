import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_chat/blocs/message_bloc/message_bloc.dart';
import 'package:flutter_bloc_chat/config/routes.dart';
import 'package:flutter_bloc_chat/models/conversation.dart';

class ConversationItem extends StatelessWidget {
  final Conversation _conversation;

  const ConversationItem(this._conversation);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .bloc<MessagesBloc>()
            .add(FetchMessagesEvent(_conversation.chatId));
        Navigator.pushNamed(context, Routes.chat,
            arguments: _conversation.chatId);
      },
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
                Text(_conversation.chatId)
              ],
            )
          ],
        ),
      ),
    );
  }
}
