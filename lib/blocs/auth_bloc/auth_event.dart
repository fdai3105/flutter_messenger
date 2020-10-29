part of  '../blocs.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppLaunchAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoginAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class GoogleLoginAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LogoutAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
