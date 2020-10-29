part of  '../blocs.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final SharedPres _sharedPres;

  AuthBloc(this._authRepository,
      this._userRepository,
      this._sharedPres,) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event,) async* {
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
      yield const AuthSuccess(null);
    } else {
      yield AuthFail();
    }
  }

  Stream<AuthState> _mapGoogleLoginAuthEventToState() async* {
    final user = await _authRepository.loginWithGoogle();
    if (user != null) {
      await SharedPres.saveUser(User.fromAuth(user));
      await _userRepository.saveUserToFirestore(user);
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
