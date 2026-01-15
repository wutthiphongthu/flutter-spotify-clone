import '../../domain/entities/auth_method.dart';
import '../../domain/entities/auth_result.dart';
import '../models/auth_payload.dart';

abstract class AuthProvider {
  AuthMethod get method;

  Future<AuthResult> signIn(AuthPayload payload);

  Future<void> signOut();
}
