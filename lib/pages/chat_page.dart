part of 'pages.dart';

class ChatPage extends StatelessWidget {
  final String cID;
  final Contact member;

  const ChatPage({Key key, this.cID, this.member})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: UI.appBarIconColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          member.name,
          style: UI.appBarTextStyle,
        ),
        backgroundColor: UI.appBarBackground,
        shadowColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.info_outline,
                color: UI.appBarIconColor,
              ),
              onPressed: () {
                // todo
              })
        ],
      ),
      body: SafeArea(
          child: Container(
            padding: UI.paddingTop,
            color: UI.bodyBackground,
            child: Column(
              children: <Widget>[
                ChatList(
                  cID: cID,
                  sendTo: member.email,
                ),
                ChatInputField(
                  cID: cID,
                  sendTo: member.email,
                ),
              ],
            ),
          )),
    );
  }
}