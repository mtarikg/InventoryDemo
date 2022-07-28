import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_demo/Models/Property/PropertyEditRequest.dart';
import 'package:inventory_demo/MyWidgets/myAlertDialog.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import 'package:inventory_demo/MyWidgets/myTextField.dart';
import 'package:inventory_demo/Services/apiService.dart';
import 'package:inventory_demo/Shared/Methods/sharedMethods.dart';
import '../Models/Property/PropertyListResponse.dart';
import '../Services/adminService.dart';
import 'mainPage.dart';

class EditProperty extends StatefulWidget {
  final int propertyID;

  const EditProperty({Key? key, required this.propertyID}) : super(key: key);

  @override
  State<EditProperty> createState() => _EditPropertyState();
}

class _EditPropertyState extends State<EditProperty> {
  late Future<PropertyListResponse> futureProperty;
  late bool imageLoaded;
  late dynamic image;
  late ValueNotifier quantityNotifier;
  late ValueNotifier descriptionNotifier;
  late ValueNotifier fullDetailNotifier;

  @override
  void initState() {
    futureProperty = ApiService().getPropertyByID(widget.propertyID);
    futureProperty.then((value) {
      _initializeVariables(value);
    });
    super.initState();
  }

  void _initializeVariables(PropertyListResponse value) {
    quantityNotifier = ValueNotifier(value.quantity.toString());
    descriptionNotifier = ValueNotifier(value.shortDescription);
    fullDetailNotifier = ValueNotifier(value.fullDetail);
    Uint8List decodedString = _decodeImageToString(value);
    image = decodedString;
  }

  Uint8List _decodeImageToString(PropertyListResponse value) {
    String base64Image = value.imageURL.toString();
    base64Image.isEmpty ? imageLoaded = false : imageLoaded = true;
    Uint8List decodedString = base64Decode(base64Image);
    return decodedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: "Edit the property",
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: FutureBuilder<PropertyListResponse>(
          future: futureProperty,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(height: 10),
                          if (imageLoaded) ...[
                            _showImage()
                          ] else ...[
                            _imagePicker()
                          ],
                          Quantity(notifier: quantityNotifier),
                          const SizedBox(height: 10),
                          ShortDescription(notifier: descriptionNotifier),
                          const SizedBox(height: 10),
                          FullDetail(notifier: fullDetailNotifier),
                          const SizedBox(height: 10),
                          AnimatedBuilder(
                              animation: Listenable.merge([
                                quantityNotifier,
                                descriptionNotifier,
                                fullDetailNotifier
                              ]),
                              builder: (context, value) {
                                return CompleteButton(
                                    context: context,
                                    id: widget.propertyID,
                                    image: image is File ? image : null,
                                    quantity: quantityNotifier,
                                    description: descriptionNotifier,
                                    fullDetail: fullDetailNotifier);
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Container _showImage() {
    return Container(
        child: image != null
            ? Stack(
                children: [
                  ClipRRect(
                    child: image is File?
                        ? Image.file(image!, width: 200, height: 200)
                        : Image.memory(image, width: 200, height: 200),
                  ),
                  Positioned(
                    right: 25,
                    height: 25,
                    width: 50,
                    child: ElevatedButton(
                      onPressed: () => setState(() {
                        image = null;
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
            title: const Text("Select from"),
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
    var selectedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80);
    setState(() {
      image = File(selectedImage!.path);
      imageLoaded = true;
    });
  }

  _gallery() async {
    Navigator.pop(context);
    var selectedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 600,
        imageQuality: 80);
    setState(() {
      image = File(selectedImage!.path);
      imageLoaded = true;
    });
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

class CompleteButton extends StatefulWidget {
  final BuildContext context;
  final int id;
  final File? image;
  final ValueNotifier quantity;
  final ValueNotifier description;
  final ValueNotifier fullDetail;

  const CompleteButton({
    Key? key,
    required this.context,
    required this.quantity,
    required this.description,
    required this.fullDetail,
    required this.id,
    this.image,
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

    PropertyEditRequest request = _createPropertyEditRequest(imageURL);
    bool result = await AdminService().editProperty(widget.id, request);

    result ? _alertComplete() : _alertError();
  }

  PropertyEditRequest _createPropertyEditRequest(String? imageURL) {
    PropertyEditRequest request = PropertyEditRequest(
        imageURL: imageURL,
        quantity: int.parse(widget.quantity.value),
        shortDescription: widget.description.value,
        fullDetail: widget.fullDetail.value);
    return request;
  }

  bool _enableButton() {
    bool quantityResult = widget.quantity.value != null;
    bool descriptionResult = widget.description.value != null;
    bool result = quantityResult && descriptionResult;
    return result;
  }

  void _alertError() {
    showDialog(
        context: context,
        builder: (context) {
          return const MyAlertDialog(
              title: "Error",
              content: "The property could not be updated. Try again.");
        });
  }

  void _alertComplete() {
    showDialog(
        context: context,
        builder: (context) {
          return const MyAlertDialog(
            title: "Complete",
            content: "The property has been updated successfully.",
            pageToNavigate: AdminMainPage(),
          );
        });
  }
}
