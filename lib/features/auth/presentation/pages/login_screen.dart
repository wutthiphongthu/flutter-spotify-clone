import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_clone/core/navigation/navigator_util.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          _showMessage(state.message);
        } else if (state is AuthAuthenticated) {
          _showMessage('Logged in as ${state.user.displayName ?? state.user.id}');
          NavigatorUtil.pushNamedAndRemoveUntil('/home');
        } else if (state is AuthSignedOut) {
          _showMessage('Signed out');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Sign in to continue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            context.read<AuthBloc>().add(
                                  AuthSignInEmailRequested(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text,
                                  ),
                                );
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Continue with Email'),
                  );
                },
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthSignInGoogleRequested(),
                      );
                },
                child: const Text('Continue with Google'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthSignInAppleRequested(),
                      );
                },
                child: const Text('Continue with Apple'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
