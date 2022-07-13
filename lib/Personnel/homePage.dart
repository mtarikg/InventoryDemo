import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';

import 'mainPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Waiting Property Requests",
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshHome,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshHome() async {
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const PersonnelMainPage(index: 0)),
        (route) => false);
  }
}
