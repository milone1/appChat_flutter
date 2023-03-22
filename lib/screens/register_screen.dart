import 'package:appchat_flutter/Helpers/show_dialog.dart';
import 'package:appchat_flutter/services/auth_service.dart';
import 'package:appchat_flutter/widgets/button_login.dart';
import 'package:appchat_flutter/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:appchat_flutter/widgets/labels_login.dart';
import 'package:appchat_flutter/widgets/login_image.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                  title: 'REGISTER',
                ),
                _Form(),
                const Labels(
                  route: 'login',
                  title: '¿Ya tienes una cuenta?',
                  subtitle: 'Ingresa Ahora',
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
  final nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity_rounded,
            placeHolder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
            isPassword: false,
          ),
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
            text: 'Crear Cuenta',
            color: authService.autenticando ? Colors.grey : Colors.blue,
            onPressed: authService.autenticando
                ? () {}
                : () async {
                    print(emailCtrl.text);
                    print(passCtrl.text);
                    final regsitroOk = await authService.register(
                        nameCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        passCtrl.text.trim());
                    if (regsitroOk == true) {
                      Navigator.pushReplacementNamed(context, 'user');
                    } else {
                      showOpenDialog(
                          context, 'Registro Incorrecto', regsitroOk);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
