import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import 'package:inventory_demo/MyWidgets/myCategoryDropdown.dart';
import 'package:inventory_demo/MyWidgets/myTextField.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({Key? key}) : super(key: key);

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  bool imageLoaded = false;
  late File? file;
  ValueNotifier nameNotifier = ValueNotifier(null);
  ValueNotifier quantityNotifier = ValueNotifier(null);
  ValueNotifier descriptionNotifier = ValueNotifier(null);
  ValueNotifier fullDetailNotifier = ValueNotifier(null);
  ValueNotifier categoryNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: "Add a new property",
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!imageLoaded) ...[
                        imagePicker(),
                      ] else ...[
                        _showImage()
                      ],
                      const SizedBox(height: 10),
                      Name(nameNotifier: nameNotifier),
                      const SizedBox(height: 10),
                      Category(notifier: categoryNotifier),
                      const SizedBox(height: 10),
                      Quantity(notifier: quantityNotifier),
                      const SizedBox(height: 10),
                      ShortDescription(notifier: descriptionNotifier),
                      const SizedBox(height: 10),
                      FullDetail(notifier: fullDetailNotifier),
                      AnimatedBuilder(
                          animation: Listenable.merge([
                            nameNotifier,
                            categoryNotifier,
                            quantityNotifier,
                            descriptionNotifier,
                            fullDetailNotifier
                          ]),
                          builder: (context, value) {
                            return CompleteButton(
                                context: context,
                                name: nameNotifier,
                                category: categoryNotifier,
                                quantity: quantityNotifier,
                                description: descriptionNotifier,
                                fullDetail: fullDetailNotifier);
                          })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Container _showImage() {
    return Container(
        child: file != null
            ? Stack(
                children: [
                  ClipRRect(
                    child: Image.file(file!, width: 200, height: 200),
                  ),
                  Positioned(
                    right: 25,
                    height: 25,
                    width: 50,
                    child: ElevatedButton(
                      onPressed: () => setState(() {
                        file = null;
                      }),
                      child: const Icon(Icons.clear,
                          size: 25, color: Colors.white),
                    ),
                  ),
                ],
              )
            : imagePicker());
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
                  camera();
                },
              ),
              SimpleDialogOption(
                child: const Text("Gallery"),
                onPressed: () {
                  gallery();
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

  camera() async {
    Navigator.pop(context);
    var image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80);
    setState(() {
      file = File(image!.path);
      imageLoaded = true;
    });
  }

  gallery() async {
    Navigator.pop(context);
    var image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80);
    setState(() {
      file = File(image!.path);
      imageLoaded = true;
    });
  }
}

class Name extends StatelessWidget {
  const Name({
    Key? key,
    required this.nameNotifier,
  }) : super(key: key);

  final ValueNotifier nameNotifier;

  @override
  Widget build(BuildContext context) {
    return MyTextField(title: "Property Name", notifier: nameNotifier);
  }
}

class FullDetail extends StatelessWidget {
  final ValueNotifier notifier;

  const FullDetail({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTextField(title: "Full Detail", height: 150, notifier: notifier);
  }
}

class ShortDescription extends StatelessWidget {
  final ValueNotifier notifier;

  const ShortDescription({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTextField(title: "Short Description", notifier: notifier);
  }
}

class Quantity extends StatelessWidget {
  final ValueNotifier notifier;

  const Quantity({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTextField(title: "Quantity", notifier: notifier);
  }
}

class Category extends StatelessWidget {
  final ValueNotifier notifier;

  const Category({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCategoryDropdown(title: "Category", selectedValue: notifier);
  }
}

class CompleteButton extends StatefulWidget {
  final BuildContext context;
  final ValueNotifier name;
  final ValueNotifier category;
  final ValueNotifier quantity;
  final ValueNotifier description;
  final ValueNotifier fullDetail;

  const CompleteButton({
    Key? key,
    required this.context,
    required this.name,
    required this.category,
    required this.quantity,
    required this.description,
    required this.fullDetail,
  }) : super(key: key);

  @override
  State<CompleteButton> createState() => _CompleteButtonState();
}

class _CompleteButtonState extends State<CompleteButton> {
  @override
  Widget build(BuildContext context) {
    bool nameResult = widget.name.value != null;
    bool categoryResult = widget.category.value != null;
    bool quantityResult = widget.quantity.value != null;
    bool descriptionResult = widget.description.value != null;
    bool isEnabled = nameResult &&
        categoryResult &&
        quantityResult &&
        descriptionResult;

    return ElevatedButton(
        onPressed: isEnabled
            ? () {
                null;
              }
            : null,
        child: const Text("Complete"));
  }
}