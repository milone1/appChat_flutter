import 'package:appchat_flutter/widgets/button_login.dart';
import 'package:appchat_flutter/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:appchat_flutter/widgets/labels_login.dart';
import 'package:appchat_flutter/widgets/login_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Logo(
                  title: 'MESSENGER',
                ),
                _Form(),
                const Labels(
                  route: 'register',
                  subtitle: 'Crea una cuenta ahora',
                  title: '¿No tienes una cuenta?',
                ),
                const Text(
                  "Terminos y concidiciones de uso",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline_rounded,
            placeHolder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
            isPassword: false,
          ),
          CustomInput(
            icon: Icons.lock_outline_rounded,
            placeHolder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          ButtonLogin(
            text: 'INGRESAR',
            onPressed: () {
              print(emailCtrl.text);
              print(passCtrl.text);
            },
          ),
        ],
      ),
    );
  }
}
