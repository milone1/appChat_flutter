import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        left: 5,
        bottom: 5,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 5),
        ],
      ),
      child: const TextField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        obscureText: true,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail_outline_rounded),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: 'Email'),
      ),
    );
  }
}
