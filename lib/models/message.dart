part of 'models.dart';

class Message {
  String text;
  int timeStamp;
  String senderName;
  String senderEmail;
  String senderAvatar;
  String sendTo;
  bool isSelf;
  String chatsID;

  Message(
      {this.text,
      this.timeStamp,
      this.senderName,
      this.senderEmail,
      this.senderAvatar,
      this.sendTo,
      this.isSelf,
      this.chatsID});

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data();
    return Message.fromMap(data);
  }

  factory Message.fromMap(Map data) {
    return Message(
        text: data[Fields.romText],
        timeStamp: data[Fields.romTime],
        senderName: data[Fields.roomSenderName],
        senderEmail: data[Fields.roomEmail],
        senderAvatar: data[Fields.messageAvatar],
        isSelf: data[Fields.roomEmail] == SharedPres.getUser().email);
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map[Fields.romText] = text;
    map[Fields.romTime] = timeStamp;
    map[Fields.roomSenderName] = senderName;
    map[Fields.messageAvatar] = SharedPres.getUser().avatar;
    map[Fields.roomEmail] = senderEmail;
    return map;
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

  @override
  String toString() {
    return 'Message{text: $text, timeStamp: $timeStamp, senderName: $senderName, senderUsername: $senderEmail, isSelf: $isSelf, documentId: $chatsID}';
  }
}
