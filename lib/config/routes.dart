part of 'config.dart';

class Routes {
  Routes._();

  static const String login = "/login";
  static const String home = "/home";
  static const String chat = "/chat";
  static const String chatInfo = "/chat_info";
  static const String findContact = "/find_contact";
  static const String setting = "/setting";

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    login: (context) => LoginPage(),
    home: (context) => HomePage(),
    chat: (context) => const ChatPage(),
    findContact: (context) => FindContactPage(),
    chatInfo: (context) => ChatInfo(),
    setting: (context) => SettingPage(),
  };
}
