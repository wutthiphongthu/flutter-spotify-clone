import 'package:injectable/injectable.dart';

import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class AuthService {
  AuthService(this._repository);

  final AuthRepository _repository;

  Future<AuthResult> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _repository.signInWithEmail(email: email, password: password);
  }

  Future<AuthResult> signInWithGoogle({
    String? idToken,
    String? accessToken,
  }) {
    return _repository.signInWithGoogle(
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<AuthResult> signInWithApple({
    String? idToken,
    String? accessToken,
  }) {
    return _repository.signInWithApple(
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<void> signOutAll() => _repository.signOutAll();
}
