import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationProvider {
  final _firebaseMessaging = FirebaseMessaging();

  void registerNotification() {
    _firebaseMessaging
      ..requestNotificationPermissions()
      ..configure(onMessage: (Map<String, dynamic> message) {
        print('onMessage: $message');
        return;
      }, onResume: (Map<String, dynamic> message) {
        print('onResume: $message');
        return;
      }, onLaunch: (Map<String, dynamic> message) {
        print('onLaunch: $message');
        return;
      });
  }
}
