part of 'models.dart';

class Message {
  String text;
  int timeStamp;
  String senderName;
  String senderEmail;
  bool isSelf;
  String chatsID;

  Message(
      {this.text,
      this.timeStamp,
      this.senderName,
      this.senderEmail,
      this.isSelf,
      this.chatsID});

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data();
    return Message.fromMap(data);
  }

  factory Message.fromMap(Map data) {
    return Message(
        chatsID: data[Fields.chatFieldsChatsID],
        text: data[Fields.chatFieldsText],
        timeStamp: data[Fields.chatFieldsTime],
        senderName: data[Fields.chatFieldsSenderName],
        senderEmail: data[Fields.chatFieldsEmail],
        isSelf: data[Fields.chatFieldsEmail] == SharedPres.getUser().email);
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
    map[Fields.chatFieldsChatsID] = chatsID;
    map[Fields.chatFieldsText] = text;
    map[Fields.chatFieldsTime] = timeStamp;
    map[Fields.chatFieldsSenderName] = senderName;
    map[Fields.chatFieldsEmail] = senderEmail;
    return map;
  }

  @override
  String toString() {
    return 'Message{text: $text, timeStamp: $timeStamp, senderName: $senderName, senderUsername: $senderEmail, isSelf: $isSelf, documentId: $chatsID}';
  }
}
