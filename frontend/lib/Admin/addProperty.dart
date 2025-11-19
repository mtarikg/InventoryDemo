import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_demo/Admin/mainPage.dart';
import 'package:inventory_demo/Models/Property/PropertyAddRequest.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import 'package:inventory_demo/MyWidgets/myCategoryDropdown.dart';
import 'package:inventory_demo/MyWidgets/myTextField.dart';
import 'package:inventory_demo/Services/adminService.dart';
import 'package:inventory_demo/Shared/Methods/sharedMethods.dart';
import '../MyWidgets/myAlertDialog.dart';

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
                      const SizedBox(height: 10),
                      if (!imageLoaded) ...[
                        _imagePicker(),
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
                      const SizedBox(height: 10),
                      AnimatedBuilder(
                          animation: Listenable.merge([
                            nameNotifier,
                            categoryNotifier,
                            quantityNotifier,
                            descriptionNotifier,
                            fullDetailNotifier,
                          ]),
                          builder: (context, value) {
                            return CompleteButton(
                                context: context,
                                image: imageLoaded ? file : null,
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
            : _imagePicker());
  }

  InkWell _imagePicker() {
    return InkWell(
      onTap: () async {
        _selectPhoto();
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

  Future _selectPhoto() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Upload image from"),
            children: [
              SimpleDialogOption(
                child: const Text("Camera"),
                onPressed: () {
                  _camera();
                },
              ),
              SimpleDialogOption(
                child: const Text("Gallery"),
                onPressed: () {
                  _gallery();
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

  _camera() async {
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

  _gallery() async {
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
  final dynamic image;
  final ValueNotifier name;
  final ValueNotifier category;
  final ValueNotifier quantity;
  final ValueNotifier description;
  final ValueNotifier fullDetail;

  const CompleteButton({
    Key? key,
    required this.context,
    required this.image,
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
    bool isEnabled = _enableButton();

    return ElevatedButton(
        onPressed: isEnabled
            ? () async {
                await _completeOperation();
              }
            : null,
        child: const Text("Complete"));
  }

  Future<void> _completeOperation() async {
    String? imageURL = await SharedMethods().convertImageToBase64(widget.image);

    PropertyAddRequest request = _createPropertyAddRequest(imageURL);
    bool result = await AdminService().addProperty(request);

    result ? _alertComplete() : _alertError();
  }

  PropertyAddRequest _createPropertyAddRequest(String? imageURL) {
    PropertyAddRequest request = PropertyAddRequest(
        name: widget.name.value,
        imageURL: imageURL,
        quantity: int.parse(widget.quantity.value),
        shortDescription: widget.description.value,
        fullDetail: widget.fullDetail.value,
        categoryID: widget.category.value);
    return request;
  }

  bool _enableButton() {
    bool nameResult =
        widget.name.value != null && widget.name.value.toString().isNotEmpty;
    bool categoryResult = widget.category.value != null;
    bool quantityResult = widget.quantity.value != null &&
        widget.quantity.value.toString().isNotEmpty;
    bool descriptionResult = widget.description.value != null &&
        widget.description.value.toString().isNotEmpty;
    bool result =
        nameResult && categoryResult && quantityResult && descriptionResult;
    return result;
  }

  void _alertError() {
    showDialog(
        context: context,
        builder: (context) {
          return const MyAlertDialog(
              title: "Error",
              content: "The property could not be added. Try again.");
        });
  }

  void _alertComplete() {
    showDialog(
        context: context,
        builder: (context) {
          return const MyAlertDialog(
            title: "Complete",
            content: "The property has been added successfully.",
            pageToNavigate: AdminMainPage(),
          );
        });
  }
}
