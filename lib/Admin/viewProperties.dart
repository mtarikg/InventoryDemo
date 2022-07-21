import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myAlertDialog.dart';
import 'package:inventory_demo/Services/adminService.dart';
import 'addPropertyForPersonnel.dart';
import 'editProperty.dart';
import '../Models/Property/PropertyListResponse.dart';
import '../Services/apiService.dart';
import '../MyWidgets/myAppBar.dart';
import 'mainPage.dart';

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
    futureProperties = ApiService().getProperties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "All Properties",
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<PropertyListResponse>>(
        future: futureProperties,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  int id = snapshot.data![index].id;
                  String name = snapshot.data![index].name.toString();
                  String? imageURL = snapshot.data![index].imageURL;
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
                                if (imageURL == null) ...[
                                  Image.asset("assets/noPropertyImage.jpg",
                                      width: 100, height: 100)
                                ] else ...[
                                  Image.memory(
                                      base64Decode(imageURL.toString()),
                                      width: 100,
                                      height: 100),
                                ],
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 35),
                                    child: Text(name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                if (widget.buttonName != null) ...[
                                  TextButton(
                                      onPressed: widget.buttonName! ==
                                              "Add to Personnel"
                                          ? () {
                                              _addToPersonnel(id);
                                            }
                                          : widget.buttonName! == "Edit"
                                              ? () {
                                                  _edit(id);
                                                }
                                              : widget.buttonName == "Delete"
                                                  ? () async {
                                                      await _delete(id);
                                                    }
                                                  : null,
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
    );
  }

  Future<void> _delete(int id) async {
    bool result = await AdminService().deleteProperty(id);
    result ? _alertComplete() : _alertError();
  }

  void _alertError() {
    showDialog(
        context: context,
        builder: (context) {
          return const MyAlertDialog(
              title: "Error",
              content: "The property could not be deleted. Try again.");
        });
  }

  void _alertComplete() {
    showDialog(
        context: context,
        builder: (context) {
          return const MyAlertDialog(
            title: "Complete",
            content: "The property has been deleted successfully.",
            pageToNavigate: AdminMainPage(),
          );
        });
  }

  void _edit(int id) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditProperty(propertyID: id)));
  }

  void _addToPersonnel(int id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddPropertyForPersonnel(propertyID: id)));
  }
}
