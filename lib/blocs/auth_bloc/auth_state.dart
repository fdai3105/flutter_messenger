part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

// authenticated
class AuthSuccess extends AuthState {
  final FirebaseAuth.User user;

  const AuthSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class AuthProgress extends AuthState {
  @override
  List<Object> get props => [];
}

// UnAuthenticated
class AuthFail extends AuthState {
  @override
  List<Object> get props => [];
}
