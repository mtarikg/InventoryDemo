import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final dynamic pageToNavigate;

  const MyAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      this.pageToNavigate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [_okButton(context)],
    );
  }

  TextButton _okButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();

          if (pageToNavigate != null) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => pageToNavigate),
                (route) => false);
          }
        },
        child: const Text("OK"));
  }
}
