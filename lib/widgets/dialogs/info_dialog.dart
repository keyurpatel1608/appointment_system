import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const InfoDialog({
    super.key,
    required this.title,
    required this.content,
    this.buttonText = 'OK',
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onButtonPressed?.call();
          },
          child: Text(buttonText),
        ),
      ],
    );
  }
}