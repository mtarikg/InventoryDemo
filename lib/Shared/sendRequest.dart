import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("Enter the necessary information below."),
          const RequestTitle(),
          const RequestCategory(),
          const RequestDescription(),
          ElevatedButton(
              onPressed: () {}, child: const Text("Send your request"))
        ],
      ),
    );
  }
}

class RequestTitle extends StatelessWidget {
  const RequestTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        children: [
          const Align(
              alignment: Alignment.topLeft, child: Text("Request Title")),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black, width: 1)),
            child: const TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 5)),
            ),
          )
        ],
      ),
    );
  }
}

class RequestDescription extends StatelessWidget {
  const RequestDescription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        children: [
          const Align(
              alignment: Alignment.topLeft, child: Text("Request Description")),
          const SizedBox(height: 10),
          Container(
            height: 200,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black, width: 1)),
            child: const TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 5)),
            ),
          )
        ],
      ),
    );
  }
}

class RequestCategory extends StatefulWidget {
  const RequestCategory({Key? key}) : super(key: key);

  @override
  State<RequestCategory> createState() => _RequestCategoryState();
}

class _RequestCategoryState extends State<RequestCategory> {
  var categories = ["Test1", "Test2"];
  String selectedCategory = "Test1";

  @override
  void initState() {
    super.initState();
  }

  void changeCategory(value) {
    setState(() {
      selectedCategory = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          const Align(
              alignment: Alignment.topLeft, child: Text("Request Category")),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black, width: 1)),
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 5)),
              hint: const Text("Select a category"),
              icon: const Icon(Icons.keyboard_arrow_down),
              onChanged: changeCategory,
              items: categories.map((valueItem) {
                return DropdownMenuItem(
                  value: valueItem,
                  child: Text(valueItem),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
