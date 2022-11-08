import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({super.key});

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
