import 'package:flutter/material.dart';
import 'package:inventory_demo/Models/PersonnelListResponse.dart';
import 'package:inventory_demo/Services/apiService.dart';
import '../MyWidgets/myAppBar.dart';

class AddPropertyForPersonnel extends StatefulWidget {
  final int propertyID;

  const AddPropertyForPersonnel({Key? key, required this.propertyID})
      : super(key: key);

  @override
  State<AddPropertyForPersonnel> createState() =>
      _AddPropertyForPersonnelState();
}

class _AddPropertyForPersonnelState extends State<AddPropertyForPersonnel> {
  late Future<List<PersonnelListResponse>> futurePersonnel;

  @override
  void initState() {
    super.initState();
    futurePersonnel = ApiService().getPersonnels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "All Personnel",
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<PersonnelListResponse>>(
          future: futurePersonnel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    String fullName = snapshot.data![index].fullName.toString();
                    String username = snapshot.data![index].username.toString();

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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(fullName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(username,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              TextButton(
                                  onPressed: () {}, child: const Text("Select"))
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
}
