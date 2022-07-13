import 'package:flutter/material.dart';

import '../MyWidgets/myAppBar.dart';

class ViewProperties extends StatelessWidget{
  const ViewProperties({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "All Properties",
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: const Text("All Properties"),
      ),
    );
  }
}