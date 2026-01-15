import 'auth_user.dart';

class AuthResult {
  const AuthResult._({required this.isSuccess, this.user, this.errorMessage});

  final bool isSuccess;
  final AuthUser? user;
  final String? errorMessage;

  factory AuthResult.success(AuthUser user) {
    return AuthResult._(isSuccess: true, user: user);
  }

  factory AuthResult.failure(String message) {
    return AuthResult._(isSuccess: false, errorMessage: message);
  }
}
