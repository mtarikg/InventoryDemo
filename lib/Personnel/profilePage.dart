import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inventory_demo/Models/Property/PropertyListResponse.dart';
import 'package:inventory_demo/MyWidgets/myCategoryDropdown.dart';
import 'package:inventory_demo/Services/apiService.dart';
import 'package:inventory_demo/Services/personnelService.dart';
import '../Models/PersonnelProperty/PersonnelPropertyListResponse.dart';
import '../MyWidgets/myAppBar.dart';
import 'mainPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  late Future<List<PersonnelPropertyListResponse>> futurePersonnelProperties;
  ValueNotifier categoryValue = ValueNotifier(null);

  @override
  void initState() {
    futurePersonnelProperties = ApiService().getPropertiesOfPersonnel(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              SelectCategoryDropdown(notifier: categoryValue),
              AnimatedBuilder(
                  animation: Listenable.merge([categoryValue]),
                  builder: (context, value) {
                    if (categoryValue.value != null) {
                      return myPropertiesOfCategory();
                    } else {
                      return myAllProperties();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<PersonnelPropertyListResponse>> myAllProperties() {
    return FutureBuilder<List<PersonnelPropertyListResponse>>(
      future: futurePersonnelProperties,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(child: Text("You have no property!")),
                )
              : ListView.builder(
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
                          String name = secondSnapshot.data!.name.toString();
                          String? imageURL = secondSnapshot.data!.imageURL;
                          String shortDescription =
                              secondSnapshot.data!.shortDescription.toString();

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
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
                                        if (imageURL == null) ...[
                                          Image.asset(
                                              "assets/noPropertyImage.jpg",
                                              width: 100,
                                              height: 100)
                                        ] else ...[
                                          Image.memory(
                                              base64Decode(imageURL.toString()),
                                              width: 100,
                                              height: 100),
                                        ],
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(shortDescription == "null"
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
                                                  fontWeight: FontWeight.bold)),
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

                        return const Center(child: CircularProgressIndicator());
                      },
                    );
                  },
                );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  FutureBuilder<List<PersonnelPropertyListResponse>> myPropertiesOfCategory() {
    return FutureBuilder<List<PersonnelPropertyListResponse>>(
      future: futurePersonnelProperties,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(child: Text("You have no property!")),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    int propertyID = snapshot.data![index].propertyID;
                    DateTime dueOn =
                        DateTime.parse(snapshot.data![index].dueOn);

                    return FutureBuilder<PropertyListResponse?>(
                      future: PersonnelService().getPropertyByCategory(
                          propertyID, categoryValue.value),
                      builder: (context, secondSnapshot) {
                        if (secondSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (secondSnapshot.hasData) {
                          String name = secondSnapshot.data!.name.toString();
                          String? imageURL = secondSnapshot.data!.imageURL;
                          String shortDescription =
                              secondSnapshot.data!.shortDescription.toString();

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
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
                                        if (imageURL == null) ...[
                                          Image.asset(
                                              "assets/noPropertyImage.jpg",
                                              width: 100,
                                              height: 100)
                                        ] else ...[
                                          Image.memory(
                                              base64Decode(imageURL.toString()),
                                              width: 100,
                                              height: 100),
                                        ],
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(shortDescription == "null"
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
                                                  fontWeight: FontWeight.bold)),
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

                        return const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Center(
                              child: Text("No property in this category!")),
                        );
                      },
                    );
                  },
                );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
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

  @override
  bool get wantKeepAlive => true;
}

class SelectCategoryDropdown extends StatelessWidget {
  const SelectCategoryDropdown({
    Key? key,
    required this.notifier,
  }) : super(key: key);

  final ValueNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return MyCategoryDropdown(title: "", selectedValue: notifier);
  }
}
