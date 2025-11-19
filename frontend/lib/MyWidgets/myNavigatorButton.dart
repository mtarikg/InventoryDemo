import 'package:flutter/material.dart';

class MyNavigatorButton extends StatelessWidget {
  final String text;
  final dynamic pageToNavigate;

  const MyNavigatorButton({Key? key, required this.text, this.pageToNavigate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      height: 100,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => pageToNavigate));
          },
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }
}
