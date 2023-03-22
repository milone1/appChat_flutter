import 'package:appchat_flutter/Helpers/show_dialog.dart';
import 'package:appchat_flutter/services/auth_service.dart';
import 'package:appchat_flutter/widgets/button_login.dart';
import 'package:appchat_flutter/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:appchat_flutter/widgets/labels_login.dart';
import 'package:appchat_flutter/widgets/login_image.dart';
import 'package:provider/provider.dart';

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
    final authService = Provider.of<AuthService>(context);
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
            color: authService.autenticando ? Colors.grey : Colors.blueAccent,
            onPressed: authService.autenticando
                ? () {}
                : () async {
                    FocusScope.of(context).unfocus();

                    final loginOk = await authService.Login(
                        emailCtrl.text.trim(), passCtrl.text.trim());
                    if (loginOk) {
                      // entrar a la ptra pantalla reemplazando la ruta que ya no se usara
                      Navigator.pushReplacementNamed(context, 'user');
                    } else {
                      showOpenDialog(context, 'Login Incorrecto!',
                          'Revise sus credenciales nuevamente');
                    }
                  },
          ),
        ],
      ),
    );
  }
}
