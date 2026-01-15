import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_clone/core/navigation/navigator_util.dart';
import 'package:flutter_spotify_clone/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_spotify_clone/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter_spotify_clone/features/auth/presentation/bloc/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOut) {
          NavigatorUtil.pushNamedAndRemoveUntil('/login');
        }
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Profile', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthSignOutRequested());
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
