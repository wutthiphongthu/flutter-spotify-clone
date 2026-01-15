import '../../domain/entities/auth_method.dart';

class AuthPayload {
  const AuthPayload._({
    required this.method,
    this.email,
    this.password,
    this.idToken,
    this.accessToken,
  });

  final AuthMethod method;
  final String? email;
  final String? password;
  final String? idToken;
  final String? accessToken;

  factory AuthPayload.email({required String email, required String password}) {
    return AuthPayload._(
      method: AuthMethod.email,
      email: email,
      password: password,
    );
  }

  factory AuthPayload.google({String? idToken, String? accessToken}) {
    return AuthPayload._(
      method: AuthMethod.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  factory AuthPayload.apple({String? idToken, String? accessToken}) {
    return AuthPayload._(
      method: AuthMethod.apple,
      idToken: idToken,
      accessToken: accessToken,
    );
  }
}
