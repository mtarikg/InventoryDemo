import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import 'package:inventory_demo/MyWidgets/myCategoryDropdown.dart';
import 'package:inventory_demo/MyWidgets/myTextField.dart';

class SendRequest extends StatelessWidget {
  final String title;
  final dynamic backgroundColor;

  const SendRequest({Key? key, required this.title, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: title,
          centerTitle: true,
          backgroundColor: backgroundColor,
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Enter the necessary information below."),
                  const RequestTitle(),
                  const RequestCategory(),
                  const RequestDescription(),
                  SendRequestButton(context: context)
                ],
              ),
            ),
          ],
        ));
  }
}

class SendRequestButton extends StatelessWidget {
  final BuildContext context;

  const SendRequestButton({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          alertComplete();
        },
        child: const Text("Send your request"));
  }

  void alertComplete() {
    Widget okButton = TextButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
        child: const Text("OK"));

    var alertDialog = AlertDialog(
      title: const Text("Complete"),
      content: const Text("Your request has been sent successfully."),
      actions: [okButton],
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}

class RequestTitle extends StatelessWidget {
  const RequestTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyTextField(title: "Request Title");
  }
}

class RequestDescription extends StatelessWidget {
  const RequestDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyTextField(title: "Request Description", height: 200);
  }
}

class RequestCategory extends StatelessWidget {
  const RequestCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyCategoryDropdown(title: "Request Category");
  }
}
