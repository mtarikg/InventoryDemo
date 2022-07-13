import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String title;
  final double? height;

  const MyTextField({Key? key, required this.title, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        children: [
          Align(alignment: Alignment.topLeft, child: Text(title)),
          const SizedBox(height: 10),
          Container(
            height: height ?? 50,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black, width: 1)),
            child: const TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 5)),
            ),
          )
        ],
      ),
    );
  }
}
