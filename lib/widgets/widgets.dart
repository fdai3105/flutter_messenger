import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_chat/blocs/contact_bloc/contact_bloc.dart';
import 'package:flutter_bloc_chat/blocs/conversation_bloc/conversation_bloc.dart';
import 'package:flutter_bloc_chat/config/paths.dart';
import 'package:flutter_bloc_chat/config/ui.dart';
import 'package:flutter_bloc_chat/models/conversation.dart';
import 'package:flutter_bloc_chat/models/user.dart';
import 'package:flutter_bloc_chat/pages/chat_page.dart';
import 'package:flutter_bloc_chat/utils/shared_pres.dart';

part 'find_contact_item.dart';
part 'cant_find.dart';
part 'conversation_item.dart';
part 'conversation_tab.dart';
part 'contact_tab.dart';
part 'setting_tab.dart';
