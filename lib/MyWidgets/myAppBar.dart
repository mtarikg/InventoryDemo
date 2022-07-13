import 'package:flutter/material.dart';
import 'package:inventory_demo/Shared/loginPage.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Color backgroundColor;
  final bool? hasLogOutButton;

  const MyAppBar(
      {Key? key,
      required this.title,
      required this.centerTitle,
      required this.backgroundColor,
      this.hasLogOutButton})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  late bool hasButton;

  @override
  void initState() {
    super.initState();
    widget.hasLogOutButton == null ? hasButton = true : hasButton = false;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: widget.centerTitle,
      backgroundColor: widget.backgroundColor,
      actions: [
        if (hasButton) ...[
          const LogOutButton()
        ]
      ],
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false);
        },
        icon: const Icon(Icons.logout));
  }
}
