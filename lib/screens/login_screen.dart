import 'dart:ui';

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              _Logo(),
              _Form(),
              _Labels(),
              Text(
                "Terminos y concidiciones de uso",
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                ),
              ),
            ],
          ),
        ));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: const <Widget>[
            Image(image: AssetImage('assets/icon.png')),
            SizedBox(
              height: 20,
            ),
            Text(
              'Messenger',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  const _Labels({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: const <Widget>[
          Text(
            "No tienes cuenta",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 15,
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Crear una ahora!',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
