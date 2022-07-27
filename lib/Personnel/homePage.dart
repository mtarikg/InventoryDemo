import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Models/PersonnelProperty/PersonnelPropertyEditRequest.dart';
import '../Models/User.dart';
import '../MyWidgets/myAppBar.dart';
import '../Models/PersonnelProperty/PersonnelPropertyListResponse.dart';
import '../Models/Property/PropertyListResponse.dart';
import '../MyWidgets/myAlertDialog.dart';
import '../Services/apiService.dart';
import '../Services/personnelService.dart';
import 'mainPage.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with AutomaticKeepAliveClientMixin {
  late int userID;
  late Future<List<PersonnelPropertyListResponse>> futurePersonnelProperties;

  @override
  void initState() {
    userID = ref.read(userProvider).id;
    futurePersonnelProperties =
        ApiService().getPropertiesOfPersonnel(userID, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const MyAppBar(
        title: "Waiting Property Requests",
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshHome,
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: waitingProperties()),
      ),
    );
  }

  FutureBuilder<List<PersonnelPropertyListResponse>> waitingProperties() {
    return FutureBuilder<List<PersonnelPropertyListResponse>>(
      future: futurePersonnelProperties,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(child: Text("There is no waiting request!")),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    int propertyID = snapshot.data![index].propertyID;
                    DateTime dueOn =
                        DateTime.parse(snapshot.data![index].dueOn);
                    final day = dueOn.day.toString().padLeft(2, "0");
                    final month = dueOn.month.toString().padLeft(2, "0");
                    final year = dueOn.year.toString();

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
                                    const EdgeInsets.fromLTRB(5, 10, 5, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
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
                                        const SizedBox(height: 10),
                                        Text(name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(shortDescription == "null"
                                            ? "No details"
                                            : shortDescription),
                                        const SizedBox(height: 10),
                                        Text("Until: $day.$month.$year",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              _rejectPersonnelProperty(
                                                  userID, propertyID);
                                            },
                                            icon: const Icon(Icons.close,
                                                color: Colors.red, size: 50)),
                                        IconButton(
                                            onPressed: () {
                                              _acceptPersonnelProperty(
                                                  userID, propertyID);
                                            },
                                            icon: const Icon(Icons.check,
                                                color: Colors.green, size: 50)),
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

  Future<void> _refreshHome() async {
    Navigator.pop(context);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const PersonnelMainPage(index: 0)),
        (route) => false);
  }

  @override
  bool get wantKeepAlive => true;

  void _rejectPersonnelProperty(int userID, int propertyID) async {
    bool result = await PersonnelService().rejectProperty(userID, propertyID);
    result ? _alertComplete("The property has been denied.") : _alertError();
  }

  void _acceptPersonnelProperty(int userID, int propertyID) async {
    PersonnelPropertyEditRequest request = PersonnelPropertyEditRequest(
        userID: userID, propertyID: propertyID, isWaiting: false);
    bool result = await PersonnelService().acceptProperty(request);
    result
        ? _alertComplete("The property has been accepted successfully.")
        : _alertError();
  }

  _alertError() {
    showDialog(
        context: context,
        builder: (context) {
          return const MyAlertDialog(
            title: "Error",
            content: "Could not complete the operation. Try again.",
            pageToNavigate: PersonnelMainPage(index: 0),
          );
        });
  }

  _alertComplete(String content) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
              title: "Complete",
              content: content,
              pageToNavigate: const PersonnelMainPage(index: 0));
        });
  }
}
