import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import 'package:inventory_demo/Personnel/homePage.dart';
import 'package:inventory_demo/Personnel/mainPage.dart';

import '../Admin/mainPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Login",
        centerTitle: true,
        backgroundColor: Colors.blue,
        hasLogOutButton: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text("Proceed as Personnel"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PersonnelMainPage()));
              },
            ),
            TextButton(
              child: const Text("Proceed as Admin"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminMainPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
