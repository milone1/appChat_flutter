import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin(
      {super.key, required this.text, required this.onPressed, this.color});
  final String text;
  final Function() onPressed;
  final color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black38),
        ),
        IconButton(
          onPressed: onPressed,
          iconSize: 76,
          color: color,
          icon: const Icon(
            Icons.arrow_circle_right_rounded,
          ),
        ),
      ],
    );
  }
}
