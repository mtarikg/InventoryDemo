import 'package:flutter/material.dart';
import 'package:inventory_demo/Admin/viewProperties.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import '../MyWidgets/myNavigatorButton.dart';
import 'addProperty.dart';
import 'editProperty.dart';

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
            AddNewProperty(),
            EditCurrentProperty(),
            DeleteCurrentProperty(),
            AddPropertyToPersonnel(),
          ],
        ),
      ),
    );
  }
}

class AddPropertyToPersonnel extends StatelessWidget {
  const AddPropertyToPersonnel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyNavigatorButton(
        text: "Add Property to Personnel",
        pageToNavigate: ViewProperties(buttonName: "Add to Personnel"));
  }
}

class DeleteCurrentProperty extends StatelessWidget {
  const DeleteCurrentProperty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyNavigatorButton(
        text: "Delete a Property",
        pageToNavigate: ViewProperties(buttonName: "Delete"));
  }
}

class EditCurrentProperty extends StatelessWidget {
  const EditCurrentProperty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyNavigatorButton(
        text: "Edit a Property",
        pageToNavigate: ViewProperties(buttonName: "Edit"));
  }
}

class AddNewProperty extends StatelessWidget {
  const AddNewProperty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyNavigatorButton(
        text: "Add a Property", pageToNavigate: AddProperty());
  }
}
