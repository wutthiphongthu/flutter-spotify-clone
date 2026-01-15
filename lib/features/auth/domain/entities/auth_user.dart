import 'auth_method.dart';

class AuthUser {
  const AuthUser({
    required this.id,
    this.email,
    this.displayName,
    required this.method,
  });

  final String id;
  final String? email;
  final String? displayName;
  final AuthMethod method;
}
