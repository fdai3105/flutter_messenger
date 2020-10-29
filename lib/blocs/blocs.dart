import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';
import '../utils/utils.dart';

part 'auth_bloc/auth_bloc.dart';

part 'auth_bloc/auth_event.dart';

part 'auth_bloc/auth_state.dart';

part 'contact_bloc/contact_bloc.dart';

part 'contact_bloc/contact_event.dart';

part 'contact_bloc/contact_state.dart';

part 'conversation_bloc/conversation_bloc.dart';

part 'conversation_bloc/conversation_event.dart';

part 'conversation_bloc/conversation_state.dart';

part 'message_bloc/message_bloc.dart';

part 'message_bloc/message_state.dart';

part 'message_bloc/message_event.dart';

part 'user_bloc/user_bloc.dart';

part 'user_bloc/user_event.dart';

part 'user_bloc/user_state.dart';
