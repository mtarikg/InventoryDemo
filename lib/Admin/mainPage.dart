import 'package:flutter/material.dart';
import '../MyWidgets/myAppBar.dart';
import '../Shared/Widgets/sendRequest.dart';
import 'propertyOperations.dart';
import '../MyWidgets/myNavigatorButton.dart';
import 'viewProperties.dart';

class AdminMainPage extends StatelessWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Main Page",
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            ShowPropertyOperations(),
            ViewAllProperties(),
            SendSupplyRequest(),
          ],
        ),
      ),
    );
  }
}

class SendSupplyRequest extends StatelessWidget {
  const SendSupplyRequest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyNavigatorButton(
        text: "Send a Supply Request",
        pageToNavigate: SendRequest(
            title: "Send a Supply Request",
            backgroundColor: Colors.blue,
            pageToNavigate: AdminMainPage()));
  }
}

class ViewAllProperties extends StatelessWidget {
  const ViewAllProperties({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyNavigatorButton(
        text: "View All Properties", pageToNavigate: ViewProperties());
  }
}

class ShowPropertyOperations extends StatelessWidget {
  const ShowPropertyOperations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyNavigatorButton(
        text: "Show Property Operations", pageToNavigate: PropertyOperations());
  }
}
