import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String title;
  final double? height;
  final ValueNotifier notifier;

  const MyTextField({
    Key? key,
    required this.title,
    this.height,
    required this.notifier,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.notifier.value);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        children: [
          Align(alignment: Alignment.topLeft, child: Text(widget.title)),
          const SizedBox(height: 10),
          Container(
            height: widget.height ?? 50,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black, width: 1)),
            child: ValueListenableBuilder(
              valueListenable: widget.notifier,
              builder: (context, _, __) {
                return TextField(
                  controller: _controller,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 5),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      widget.notifier.value = value;
                    });
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
