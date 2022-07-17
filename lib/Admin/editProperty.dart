import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import 'package:inventory_demo/MyWidgets/myTextField.dart';

class EditProperty extends StatefulWidget {
  const EditProperty({Key? key}) : super(key: key);

  @override
  State<EditProperty> createState() => _EditPropertyState();
}

class _EditPropertyState extends State<EditProperty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: "Edit the property",
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    imagePicker(),
                    const SizedBox(height: 10),
                    const Quantity(),
                    const ShortDescription(),
                    const FullDetail(),
                    const CompleteButton()
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  InkWell imagePicker() {
    return InkWell(
      onTap: () async {
        selectPhoto();
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(75, 25, 75, 25),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.add, size: 100, color: Colors.white),
      ),
    );
  }

  Future selectPhoto() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Select from"),
            children: [
              SimpleDialogOption(
                child: const Text("Camera"),
                onPressed: () {
                  //camera();
                },
              ),
              SimpleDialogOption(
                child: const Text("Gallery"),
                onPressed: () {
                  //gallery();
                },
              ),
              SimpleDialogOption(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}

class FullDetail extends StatelessWidget {
  const FullDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyTextField(title: "Full Detail", height: 150);
  }
}

class ShortDescription extends StatelessWidget {
  const ShortDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyTextField(title: "Short Description");
  }
}

class Quantity extends StatelessWidget {
  const Quantity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyTextField(title: "Quantity");
  }
}

class CompleteButton extends StatelessWidget {
  const CompleteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: const Text("Complete"));
  }
}
