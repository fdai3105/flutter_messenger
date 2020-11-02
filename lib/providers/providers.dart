import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_chat/models/last_message.dart';
import 'package:flutter_bloc_chat/providers/notification_provider.dart';
import '../config/config.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';
import '../utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

part "auth_provider.dart";

part 'contact_provider.dart';

part 'conversation_provider.dart';

part 'message_provider.dart';

part 'user_provider.dart';

abstract class Provider {
  Provider();

  void dispose();
}
