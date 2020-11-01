part of 'models.dart';

class Message {
  String text;
  int timeStamp;
  String senderName;
  String senderEmail;
  String sendTo;
  bool isSelf;
  String chatsID;

  Message(
      {this.text,
      this.timeStamp,
      this.senderName,
      this.senderEmail,
      this.sendTo,
      this.isSelf,
      this.chatsID});

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data();
    return Message.fromMap(data);
  }

  factory Message.fromMap(Map data) {
    return Message(
        chatsID: data[Fields.chatChatsID],
        text: data[Fields.chatText],
        timeStamp: data[Fields.chatTime],
        senderName: data[Fields.chatSenderName],
        senderEmail: data[Fields.chatEmail],
        isSelf: data[Fields.chatEmail] == SharedPres.getUser().email);
  }

  // ignore: missing_return
  factory Message.fromQuerySnapShot(
      QuerySnapshot snapshot, EventSink<List<Message>> sink) {
    final messages = <Message>[];
    snapshot.docs.forEach((element) {
      messages.add(Message.fromFirestore(element));
    });
    sink.add(messages);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map[Fields.chatChatsID] = chatsID;
    map[Fields.chatText] = text;
    map[Fields.chatTime] = timeStamp;
    map[Fields.chatSenderName] = senderName;
    map[Fields.chatEmail] = senderEmail;
    map[Fields.chatSendTo] = sendTo;
    return map;
  }

  @override
  String toString() {
    return 'Message{text: $text, timeStamp: $timeStamp, senderName: $senderName, senderUsername: $senderEmail, isSelf: $isSelf, documentId: $chatsID}';
  }
}
