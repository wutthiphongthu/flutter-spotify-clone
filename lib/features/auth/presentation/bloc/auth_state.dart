import '../../domain/entities/auth_user.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);

  final AuthUser user;
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message);

  final String message;
}

class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}
