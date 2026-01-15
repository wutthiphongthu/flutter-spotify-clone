abstract class AuthEvent {
  const AuthEvent();
}

class AuthSignInEmailRequested extends AuthEvent {
  const AuthSignInEmailRequested({required this.email, required this.password});

  final String email;
  final String password;
}

class AuthSignInGoogleRequested extends AuthEvent {
  const AuthSignInGoogleRequested({this.idToken, this.accessToken});

  final String? idToken;
  final String? accessToken;
}

class AuthSignInAppleRequested extends AuthEvent {
  const AuthSignInAppleRequested({this.idToken, this.accessToken});

  final String? idToken;
  final String? accessToken;
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}
