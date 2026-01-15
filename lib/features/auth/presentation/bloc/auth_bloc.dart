import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/auth_result.dart';
import '../../domain/usecases/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authService) : super(const AuthInitial()) {
    on<AuthSignInEmailRequested>(_onSignInEmail);
    on<AuthSignInGoogleRequested>(_onSignInGoogle);
    on<AuthSignInAppleRequested>(_onSignInApple);
    on<AuthSignOutRequested>(_onSignOut);
  }

  final AuthService _authService;

  Future<void> _onSignInEmail(
    AuthSignInEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _authService.signInWithEmail(
      email: event.email,
      password: event.password,
    );
    _emitResult(result, emit);
  }

  Future<void> _onSignInGoogle(
    AuthSignInGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _authService.signInWithGoogle(
      idToken: event.idToken,
      accessToken: event.accessToken,
    );
    _emitResult(result, emit);
  }

  Future<void> _onSignInApple(
    AuthSignInAppleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _authService.signInWithApple(
      idToken: event.idToken,
      accessToken: event.accessToken,
    );
    _emitResult(result, emit);
  }

  Future<void> _onSignOut(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authService.signOutAll();
    emit(const AuthSignedOut());
  }

  void _emitResult(AuthResult result, Emitter<AuthState> emit) {
    final user = result.user;
    if (result.isSuccess && user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthFailure(result.errorMessage ?? 'Unknown error'));
    }
  }
}
