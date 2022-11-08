import 'package:flutter/material.dart';
import 'package:appchat_flutter/widgets/labels_login.dart';
import 'package:appchat_flutter/widgets/login_image.dart';
import 'package:appchat_flutter/components/form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Logo(),
              FormLogin(),
              const Labels(),
              const Text(
                "Terminos y concidiciones de uso",
                style: TextStyle(
                  fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
