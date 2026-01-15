import 'package:injectable/injectable.dart';

import '../../domain/entities/auth_method.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/entities/auth_user.dart';
import '../models/auth_payload.dart';
import 'auth_provider.dart';

@lazySingleton
class EmailAuthProvider implements AuthProvider {
  @override
  AuthMethod get method => AuthMethod.email;

  @override
  Future<AuthResult> signIn(AuthPayload payload) async {
    if (payload.email == null || payload.password == null) {
      return AuthResult.failure('Email and password are required.');
    }
    return AuthResult.success(
      AuthUser(
        id: payload.email!,
        email: payload.email,
        displayName: payload.email,
        method: method,
      ),
    );
  }

  @override
  Future<void> signOut() async {}

  AuthResult mockSuccess({required String id, required String email}) {
    return AuthResult.success(
      AuthUser(id: id, email: email, displayName: email, method: method),
    );
  }
}
