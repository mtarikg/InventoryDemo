import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import 'package:inventory_demo/MyWidgets/myTextField.dart';

class EditProperty extends StatefulWidget {
  final int propertyID;

  const EditProperty({Key? key, required this.propertyID}) : super(key: key);

  @override
  State<EditProperty> createState() => _EditPropertyState();
}

class _EditPropertyState extends State<EditProperty> {
  ValueNotifier quantityNotifier = ValueNotifier(null);
  ValueNotifier descriptionNotifier = ValueNotifier(null);
  ValueNotifier fullDetailNotifier = ValueNotifier(null);

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
                    Quantity(notifier: quantityNotifier),
                    ShortDescription(notifier: descriptionNotifier),
                    FullDetail(notifier: fullDetailNotifier),
                    AnimatedBuilder(
                        animation: Listenable.merge([
                          quantityNotifier,
                          descriptionNotifier,
                          fullDetailNotifier
                        ]),
                        builder: (context, value) {
                          return CompleteButton(
                              context: context,
                              quantity: quantityNotifier,
                              description: descriptionNotifier,
                              fullDetail: fullDetailNotifier);
                        })
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
  final ValueNotifier quantity;
  final ValueNotifier description;
  final ValueNotifier fullDetail;

  const CompleteButton({
    Key? key,
    required this.context,
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
    bool quantityResult = widget.quantity.value != null;
    bool descriptionResult = widget.description.value != null;
    bool isEnabled = quantityResult && descriptionResult;

    return ElevatedButton(
        onPressed: isEnabled
            ? () {
                null;
              }
            : null,
        child: const Text("Complete"));
  }
}
