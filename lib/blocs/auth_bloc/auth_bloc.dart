import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter_bloc_chat/repositories/user_repository.dart';
import '../../models/user.dart';
import 'package:flutter_bloc_chat/utils/shared_pres.dart';
import '../../repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final SharedPres _sharedPres;

  AuthBloc(
    this._authRepository,
    this._userRepository,
    this._sharedPres,
  ) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppLaunchAuthEvent) {
      yield* _mapAppLaunchAuthEventToState();
    } else if (event is GoogleLoginAuthEvent) {
      yield* _mapGoogleLoginAuthEventToState();
    } else if (event is LogoutAuthEvent) {
      yield* _mapLogoutAuthEventToState();
    }
  }

  Stream<AuthState> _mapAppLaunchAuthEventToState() async* {
    yield AuthProgress();
    if (await _authRepository.isLoggedIn()) {
      yield AuthSuccess(null);
    } else {
      yield AuthFail();
    }
  }

  Stream<AuthState> _mapGoogleLoginAuthEventToState() async* {
    final user = await _authRepository.loginWithGoogle();
    if (user != null) {
      await SharedPres.saveUser(User.fromAuth(user));
      _userRepository.saveUserToFirestore(user);
      try {
        yield AuthSuccess(user);
      } catch (e) {
        yield AuthFail();
      }
    } else {
      yield AuthFail();
    }
  }

  Stream<AuthState> _mapLogoutAuthEventToState() async* {
    await _authRepository.signOut();
    await _sharedPres.clearAll();
    yield AuthFail();
  }
}
