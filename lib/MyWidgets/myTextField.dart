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
  final _controller = TextEditingController();

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
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 5),
                  ),
                  onEditingComplete: () {
                    widget.notifier.value = _controller.text;
                    FocusManager.instance.primaryFocus?.unfocus();
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
