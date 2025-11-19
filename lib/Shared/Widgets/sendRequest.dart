import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import 'package:inventory_demo/MyWidgets/myCategoryDropdown.dart';
import 'package:inventory_demo/MyWidgets/myTextField.dart';
import '../../MyWidgets/myAlertDialog.dart';

class SendRequest extends StatefulWidget {
  final String title;
  final dynamic backgroundColor;
  final dynamic pageToNavigate;

  const SendRequest(
      {Key? key,
      required this.title,
      required this.backgroundColor,
      required this.pageToNavigate})
      : super(key: key);

  @override
  State<SendRequest> createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  ValueNotifier titleValue = ValueNotifier(null);
  ValueNotifier descriptionValue = ValueNotifier(null);
  ValueNotifier categoryValue = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: widget.title,
          centerTitle: true,
          backgroundColor: widget.backgroundColor,
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Enter the necessary information below."),
                  Title(notifier: titleValue),
                  Category(notifier: categoryValue),
                  Description(notifier: descriptionValue),
                  AnimatedBuilder(
                      animation: Listenable.merge(
                          [titleValue, descriptionValue, categoryValue]),
                      builder: (context, value) {
                        return SendButton(
                            context: context,
                            backgroundColor: widget.backgroundColor,
                            pageToNavigate: widget.pageToNavigate,
                            title: titleValue,
                            description: descriptionValue,
                            category: categoryValue);
                      })
                ],
              ),
            ),
          ],
        ));
  }
}

class Description extends StatelessWidget {
  final ValueNotifier notifier;

  const Description({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTextField(
        title: "Request Description", height: 200, notifier: notifier);
  }
}

class Title extends StatelessWidget {
  final ValueNotifier notifier;

  const Title({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      title: "Request Title",
      notifier: notifier,
    );
  }
}

class SendButton extends StatefulWidget {
  final BuildContext context;
  final dynamic backgroundColor;
  final dynamic pageToNavigate;
  final ValueNotifier title;
  final ValueNotifier description;
  final ValueNotifier category;

  const SendButton(
      {Key? key,
      required this.context,
      required this.backgroundColor,
      required this.pageToNavigate,
      required this.title,
      required this.description,
      required this.category})
      : super(key: key);

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool titleResult = widget.title.value != null;
    bool descriptionResult = widget.description.value != null;
    bool categoryResult = widget.category.value != null;
    bool isEnabled = titleResult && descriptionResult && categoryResult;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: widget.backgroundColor),
        onPressed: isEnabled
            ? () {
                _alertComplete(widget.pageToNavigate);
              }
            : null,
        child: const Text("Send your request"));
  }

  void _alertComplete(dynamic pageToNavigate) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
            title: "Complete",
            content: "Your request has been sent successfully.",
            pageToNavigate: pageToNavigate,
          );
        });
  }
}

class Category extends StatelessWidget {
  final ValueNotifier notifier;

  const Category({Key? key, required this.notifier}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCategoryDropdown(
        title: "Request Category", selectedValue: notifier);
  }
}
