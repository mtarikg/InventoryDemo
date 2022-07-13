import 'package:flutter/material.dart';

class MyCategoryDropdown extends StatefulWidget {
  final String title;

  const MyCategoryDropdown({Key? key, required this.title}) : super(key: key);

  @override
  State<MyCategoryDropdown> createState() => _MyCategoryDropdownState();
}

class _MyCategoryDropdownState extends State<MyCategoryDropdown> {
  var categories = ["Test1", "Test2"];
  String selectedCategory = "";

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
          Align(alignment: Alignment.topLeft, child: Text(widget.title)),
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
