import 'package:flutter/material.dart';
import 'package:flutter_spotify_clone/core/navigation/navigator_util.dart';
import 'package:flutter_spotify_clone/core/di/injection.dart';
import 'package:flutter_spotify_clone/core/storage/token_storage.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final tokenStorage = getIt<TokenStorage>();
    await Future.delayed(const Duration(seconds: 2));
    final token = await tokenStorage.readAccessToken();
    if (!mounted) {
      return;
    }
    if (token == null || token.isEmpty) {
      NavigatorUtil.pushNamedAndRemoveUntil('/login');
    } else {
      NavigatorUtil.pushNamedAndRemoveUntil('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.music_note, color: Colors.green, size: 72),
            SizedBox(height: 16),
            Text(
              'Spotify Clone',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}
