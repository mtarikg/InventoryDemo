import 'package:flutter/material.dart';
import 'package:inventory_demo/Models/CategoryListResponse.dart';
import 'package:inventory_demo/Services/apiService.dart';

class MyCategoryDropdown extends StatefulWidget {
  final String title;
  final ValueNotifier selectedValue;

  const MyCategoryDropdown(
      {Key? key, required this.title, required this.selectedValue})
      : super(key: key);

  @override
  State<MyCategoryDropdown> createState() => _MyCategoryDropdownState();
}

class _MyCategoryDropdownState extends State<MyCategoryDropdown>
    with AutomaticKeepAliveClientMixin {
  late Future<List<CategoryListResponse>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = ApiService().getCategories();
  }

  @override
  void dispose() {
    widget.selectedValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          Align(alignment: Alignment.topLeft, child: Text(widget.title)),
          const SizedBox(height: 10),
          FutureBuilder<List<CategoryListResponse>>(
            future: futureCategories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.black, width: 1)),
                  child: ValueListenableBuilder(
                      valueListenable: widget.selectedValue,
                      builder: (context, value, _) {
                        return DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 5)),
                          hint: const Text("Select a category"),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          onChanged: (value) {
                            widget.selectedValue.value =
                                (value as CategoryListResponse).id;
                          },
                          items: snapshot.data!.map((valueItem) {
                            String name = valueItem.name;

                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(name),
                            );
                          }).toList(),
                        );
                      }),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
