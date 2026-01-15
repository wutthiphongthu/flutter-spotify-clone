import 'package:injectable/injectable.dart';

import '../../domain/entities/auth_method.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/entities/auth_user.dart';
import '../models/auth_payload.dart';
import 'auth_provider.dart';

@lazySingleton
class GoogleAuthProvider implements AuthProvider {
  @override
  AuthMethod get method => AuthMethod.google;

  @override
  Future<AuthResult> signIn(AuthPayload payload) async {
    return AuthResult.success(
      AuthUser(
        id: 'google_user_001',
        email: payload.idToken != null ? 'google_user@example.com' : null,
        displayName: 'Google User',
        method: method,
      ),
    );
  }

  @override
  Future<void> signOut() async {}

  AuthResult mockSuccess({required String id, String? email}) {
    return AuthResult.success(
      AuthUser(id: id, email: email, displayName: email, method: method),
    );
  }
}
