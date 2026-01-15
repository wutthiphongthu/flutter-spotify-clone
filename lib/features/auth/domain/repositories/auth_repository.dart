import '../entities/auth_result.dart';

abstract class AuthRepository {
  Future<AuthResult> signInWithEmail({
    required String email,
    required String password,
  });

  Future<AuthResult> signInWithGoogle({String? idToken, String? accessToken});

  Future<AuthResult> signInWithApple({String? idToken, String? accessToken});

  Future<void> signOutAll();
}
