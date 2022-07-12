import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Waiting Property Requests",
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}