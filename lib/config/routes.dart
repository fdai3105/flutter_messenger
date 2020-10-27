import 'package:flutter/material.dart';
import 'package:flutter_bloc_chat/pages/chat_info.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';
import '../pages/chat_page.dart';

class Routes {
  Routes._();

  static const String login = "/login";
  static const String home = "/home";
  static const String chat = "/chat";
  static const String chatInfo = "/chat_info";
  static const String setting = "/setting";

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    login: (context) => LoginPage(),
    home: (context) => HomePage(),
    chat: (context) => ChatPage(),
    chatInfo: (context) => ChatInfo(),
    // setting: (context) => SettingPage(),
  };
}
