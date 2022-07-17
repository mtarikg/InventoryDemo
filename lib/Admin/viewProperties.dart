import 'package:flutter/material.dart';
import 'addPropertyForPersonnel.dart';
import 'editProperty.dart';
import '../Models/PropertyListResponse.dart';
import '../Services/apiService.dart';
import '../MyWidgets/myAppBar.dart';

class ViewProperties extends StatefulWidget {
  final String? buttonName;

  const ViewProperties({Key? key, this.buttonName}) : super(key: key);

  @override
  State<ViewProperties> createState() => _ViewPropertiesState();
}

class _ViewPropertiesState extends State<ViewProperties> {
  late Future<List<PropertyListResponse>> futureProperties;

  @override
  void initState() {
    super.initState();
    futureProperties = ApiService().getProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "All Properties",
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<PropertyListResponse>>(
          future: futureProperties,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    int id = snapshot.data![index].id;
                    String name = snapshot.data![index].name.toString();
                    String imageURL = snapshot.data![index].imageURL.toString();
                    String fullDetail =
                        snapshot.data![index].fullDetail.toString();
                    String shortDescription =
                        snapshot.data![index].shortDescription.toString();

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 5, 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(imageURL,
                                      height: 100, width: 100),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(fullDetail == "null"
                                          ? shortDescription == "null"
                                              ? "No details"
                                              : shortDescription
                                          : "No details"),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  if (widget.buttonName != null) ...[
                                    TextButton(
                                        onPressed: () {
                                          _buttonOperations(context, id);
                                        },
                                        child: Text(
                                          widget.buttonName!,
                                        )),
                                  ],
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void _buttonOperations(BuildContext context, int propertyID) {
    if (widget.buttonName! == "Add to Personnel") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AddPropertyForPersonnel(propertyID: propertyID)));
    } else if (widget.buttonName! == "Edit") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditProperty(propertyID: propertyID)));
    } else if (widget.buttonName! == "Delete") {}
  }
}
