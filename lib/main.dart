import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_chat/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc_chat/blocs/message_bloc/message_bloc.dart';
import 'package:flutter_bloc_chat/pages/login_page.dart';
import 'package:flutter_bloc_chat/providers/message_provider.dart';
import 'package:flutter_bloc_chat/repositories/auth_repository.dart';
import 'package:flutter_bloc_chat/repositories/conversation_repository.dart';
import 'package:flutter_bloc_chat/repositories/message_repository.dart';
import 'package:flutter_bloc_chat/repositories/user_repository.dart';
import 'package:flutter_bloc_chat/simple_bloc_observer.dart';
import 'package:flutter_bloc_chat/utils/shared_pres.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/routes.dart';
import 'blocs/conversation_bloc/conversation_bloc.dart';
import 'pages/home_page.dart';
import 'providers/conversation_provider.dart';

// ignore: avoid_void_async
void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPres.prefsInstance();

  final _sharePrefs = SharedPres();
  final _authRepository = AuthRepository();
  final _conversationRepository = ConversationRepository();
  final _messageRepository = MessageRepository();
  final _userRepository = UserRepository();

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(create: (context) {
      return AuthBloc(_authRepository, _userRepository, _sharePrefs)
        ..add(AppLaunchAuthEvent());
    }),
    BlocProvider<ConversationBloc>(create: (context) {
      return ConversationBloc(_conversationRepository)
        ..add(FetchConversationEvent());
    }),
    BlocProvider<MessagesBloc>(create: (context) {
      return MessagesBloc(_messageRepository);
    })
  ], child: MainApp()));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AuthSuccess) {
          return HomePage();
        } else if (state is AuthFail) {
          return LoginPage();
        } else if (state is AuthProgress) {
          return const CircularProgressIndicator();
        } else {
          return const Text("data");
        }
      }),
      routes: Routes.routes,
    );
  }
}
