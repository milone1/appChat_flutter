import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showOpenDialog(BuildContext context, String title, String subTitle) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(subTitle),
        actions: <Widget>[
          MaterialButton(
            child: Text('OK'),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
  showCupertinoDialog(
    context: context,
    builder: (_) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(subTitle),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ),
  );
}
