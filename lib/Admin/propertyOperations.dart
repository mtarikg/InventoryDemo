import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import '../MyWidgets/myNavigatorButton.dart';

class PropertyOperations extends StatelessWidget {
  const PropertyOperations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Property Operations",
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            MyNavigatorButton(
                text: "Add a Property", pageToNavigate: PropertyOperations()),
            MyNavigatorButton(
                text: "Edit a Property", pageToNavigate: PropertyOperations()),
            MyNavigatorButton(
                text: "Delete a Property",
                pageToNavigate: PropertyOperations()),
            MyNavigatorButton(
                text: "Add Property to Personnel",
                pageToNavigate: PropertyOperations()),
          ],
        ),
      ),
    );
  }
}
