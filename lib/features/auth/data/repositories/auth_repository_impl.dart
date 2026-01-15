import 'package:injectable/injectable.dart';

import '../../domain/entities/auth_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/apple_auth_provider.dart';
import '../datasources/email_auth_provider.dart';
import '../datasources/google_auth_provider.dart';
import '../models/auth_payload.dart';
import '../../../../core/storage/token_storage.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._emailAuthProvider,
    this._googleAuthProvider,
    this._appleAuthProvider,
    this._tokenStorage,
  );

  final EmailAuthProvider _emailAuthProvider;
  final GoogleAuthProvider _googleAuthProvider;
  final AppleAuthProvider _appleAuthProvider;
  final TokenStorage _tokenStorage;

  @override
  Future<AuthResult> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _signInAndPersist(
      _emailAuthProvider.signIn(
        AuthPayload.email(email: email, password: password),
      ),
    );
  }

  @override
  Future<AuthResult> signInWithGoogle({String? idToken, String? accessToken}) {
    return _signInAndPersist(
      _googleAuthProvider.signIn(
        AuthPayload.google(idToken: idToken, accessToken: accessToken),
      ),
    );
  }

  @override
  Future<AuthResult> signInWithApple({String? idToken, String? accessToken}) {
    return _signInAndPersist(
      _appleAuthProvider.signIn(
        AuthPayload.apple(idToken: idToken, accessToken: accessToken),
      ),
    );
  }

  Future<AuthResult> _signInAndPersist(Future<AuthResult> resultFuture) async {
    final result = await resultFuture;
    if (result.isSuccess) {
      await _tokenStorage.saveTokens(
        accessToken: 'mock_access_token',
        refreshToken: 'mock_refresh_token',
      );
    }
    return result;
  }

  @override
  Future<void> signOutAll() async {
    await _emailAuthProvider.signOut();
    await _googleAuthProvider.signOut();
    await _appleAuthProvider.signOut();
    await _tokenStorage.clear();
  }
}
