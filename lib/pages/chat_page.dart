import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_chat/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc_chat/blocs/conversation_bloc/conversation_bloc.dart';
import 'package:flutter_bloc_chat/blocs/message_bloc/message_bloc.dart';
import 'package:flutter_bloc_chat/config/constants.dart';
import 'package:flutter_bloc_chat/config/routes.dart';
import 'package:flutter_bloc_chat/models/message.dart';
import 'package:flutter_bloc_chat/pages/chat_info.dart';
import 'package:flutter_bloc_chat/pages/home_page.dart';
import 'package:flutter_bloc_chat/utils/shared_pres.dart';
import 'package:flutter_bloc_chat/widgets/chat_item.dart';

class ChatPage extends StatelessWidget {
  final String chatID;
  final bool runFromHome;
  final String sendTo;

  const ChatPage(
      {Key key, this.chatID, @required this.runFromHome, @required this.sendTo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('UserName'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                // todo
              })
        ],
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          _Chats(
            chatID: chatID,
            runFromHome: runFromHome,
          ),
          _ChatInputField(
            chatID: chatID,
            sendTo: sendTo,
          ),
        ],
      )),
    );
  }
}

class _Chats extends StatefulWidget {
  final String chatID;
  final bool runFromHome;

  const _Chats({Key key, this.chatID, this.runFromHome}) : super(key: key);

  @override
  __ChatsState createState() => __ChatsState();
}

class __ChatsState extends State<_Chats> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.bloc<MessagesBloc>().add(FetchMessagesEvent(widget.chatID));
    _controller.addListener(() {
      final maxScroll = _controller.position.maxScrollExtent;
      final currentScroll = _controller.position.pixels;
      if (maxScroll == currentScroll) {
        print('reach to top');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MessagesBloc, MessagesState>(
        builder: (context, state) {
          if (state is MessagesSuccess) {
            return ListView.builder(
                controller: _controller,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      child: ChatItem(message: state.messages[index]));
                });
          } else if (state is MessagesProgress) {
            return const CircularProgressIndicator();
          } else {
            return Text("data");
          }
        },
      ),
    );
  }
}

class _ChatInputField extends StatelessWidget {
  final String chatID;
  final String sendTo;

  var _editingController = TextEditingController();

  _ChatInputField({Key key, @required this.chatID, @required this.sendTo})
      : super(key: key);

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
                        final message = Message(
                            text: _text,
                            timeStamp: DateTime.now().millisecondsSinceEpoch,
                            senderName: SharedPres.getUser().name,
                            senderEmail: SharedPres.getUser().email);
                        context
                            .bloc<MessagesBloc>()
                            .add(SendMessageEvent(chatID, message, sendTo));
                        _editingController.clear();
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
