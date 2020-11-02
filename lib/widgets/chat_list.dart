part of 'widgets.dart';

class ChatList extends StatefulWidget {
  final String cID;
  final String sendTo;

  const ChatList({Key key, this.cID, this.sendTo}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.bloc<MessagesBloc>().add(FetchMessagesEvent(widget.cID));
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
            if (state.messages.isNotEmpty) {
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
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "${Paths.assetIllustrations}/mail_love.png",
                      height: 200,
                    ),
                    Text(
                      "Let's begin conversation",
                      style: UI.textStyle
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FlatButton(
                        onPressed: () {
                          context.bloc<MessagesBloc>().add(SendMessageEvent(
                              widget.cID, "Hi!", widget.sendTo));
                        },
                        child: Text(
                          "Send hi!",
                          style: UI.textStyle.copyWith(
                              color: UI.primaryColor,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              );
            }
          } else if (state is MessagesProgress) {
            return Container(
                height: 50,
                width: 50,
                child: const CircularProgressIndicator());
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
