import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels(
      {super.key,
      required this.route,
      required this.title,
      required this.subTitle});
  final String route;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          subTitle,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 15,
            fontWeight: FontWeight.w200,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
        )
      ],
    );
  }
}
