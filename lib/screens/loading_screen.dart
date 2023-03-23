import 'package:appchat_flutter/screens/login_screen.dart';
import 'package:appchat_flutter/screens/user_screen.dart';
import 'package:appchat_flutter/services/auth_service.dart';
import 'package:appchat_flutter/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: checkLoginState(context),
          builder: (context, snapshot) {
            return const Center(
              child: Text('Loading Screen'),
            );
          }),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final autenticando = await authService.isLoggedIn();
    if (autenticando) {
      socketService.connect();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (
              _,
              __,
              ___,
            ) =>
                UserScreen(),
            transitionDuration: const Duration(
              milliseconds: 0,
            ),
          ));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (
              _,
              __,
              ___,
            ) =>
                const LoginScreen(),
            transitionDuration: const Duration(
              milliseconds: 0,
            ),
          ));
    }
  }
}
