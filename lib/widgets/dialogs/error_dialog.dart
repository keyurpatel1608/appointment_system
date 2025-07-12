import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const ErrorDialog({
    super.key,
    this.title = 'Error',
    required this.content,
    this.buttonText = 'OK',
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(color: Colors.red)),
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