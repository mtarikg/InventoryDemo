import 'package:flutter/material.dart';
import 'package:inventory_demo/Models/PropertyListResponse.dart';
import 'package:inventory_demo/MyWidgets/myCategoryDropdown.dart';
import 'package:inventory_demo/Services/apiService.dart';
import '../Models/PersonnelPropertyListResponse.dart';
import '../MyWidgets/myAppBar.dart';
import 'mainPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<List<PersonnelPropertyListResponse>> futurePersonnelProperties;

  @override
  void initState() {
    super.initState();
    futurePersonnelProperties = ApiService().getPropertiesOfPersonnel(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "My Properties",
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProfile,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SelectCategoryDropdown(),
              FutureBuilder<List<PersonnelPropertyListResponse>>(
                future: futurePersonnelProperties,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        int propertyID = snapshot.data![index].propertyID;
                        DateTime dueOn =
                            DateTime.parse(snapshot.data![index].dueOn);

                        return FutureBuilder<PropertyListResponse>(
                          future: ApiService().getPropertyByID(propertyID),
                          builder: (context, secondSnapshot) {
                            if (secondSnapshot.hasData) {
                              String name =
                                  secondSnapshot.data!.name.toString();
                              String imageURL =
                                  secondSnapshot.data!.imageURL.toString();
                              String shortDescription = secondSnapshot
                                  .data!.shortDescription
                                  .toString();

                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(width: 1),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 15, 5, 5),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Image.network(imageURL,
                                                height: 100, width: 100),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      shortDescription == "null"
                                                          ? "No details"
                                                          : shortDescription),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                      "Until: ${dueOn.day}.${dueOn.month}.${dueOn.year}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ],
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
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else if (secondSnapshot.hasError) {
                              return Text('${secondSnapshot.error}');
                            }

                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshProfile() async {
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const PersonnelMainPage(index: 1)),
        (route) => false);
  }
}

class SelectCategoryDropdown extends StatelessWidget {
  const SelectCategoryDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyCategoryDropdown(title: "");
  }
}
