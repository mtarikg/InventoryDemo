import 'package:flutter/material.dart';
import 'package:inventory_demo/Models/Personnel/PersonnelListResponse.dart';
import 'package:inventory_demo/Models/PersonnelProperty/PersonnelPropertyAddRequest.dart';
import 'package:inventory_demo/Services/adminService.dart';
import 'package:inventory_demo/Services/apiService.dart';
import '../MyWidgets/myAlertDialog.dart';
import '../MyWidgets/myAppBar.dart';
import 'mainPage.dart';

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
    futurePersonnel = ApiService().getPersonnel();
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
                    int userID = snapshot.data![index].id;
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
                                  onPressed: () async {
                                    await _completeOperation(userID);
                                  },
                                  child: const Text("Select"))
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

  Future<void> _completeOperation(int userID) async {
    final dueDate = await _showDateTimePicker();

    PersonnelPropertyAddRequest request =
        _createPersonnelPropertyAddRequest(widget.propertyID, userID, dueDate);

    bool result = await AdminService().addPropertyToPersonnel(userID, request);

    result ? _alertComplete() : _alertError();
  }

  Future<DateTime> _showDateTimePicker() async {
    DateTime? date = await _selectDate();
    TimeOfDay? time = await _selectTime();

    final dateTime =
        DateTime(date!.year, date.month, date.day, time!.hour, time.minute);

    return dateTime;
  }

  Future<DateTime?> _selectDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2050));

  Future<TimeOfDay?> _selectTime() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());

  PersonnelPropertyAddRequest _createPersonnelPropertyAddRequest(
      int propertyID, int userID, DateTime dueDate) {
    PersonnelPropertyAddRequest request = PersonnelPropertyAddRequest(
        propertyID: propertyID,
        personnelID: userID,
        dueOn: dueDate,
        isWaiting: true);

    return request;
  }

  void _alertError() {
    showDialog(
        context: context,
        builder: (context) {
          return const MyAlertDialog(
              title: "Error",
              content:
                  "The property was added to the personnel before.");
        });
  }

  void _alertComplete() {
    showDialog(
        context: context,
        builder: (context) {
          return const MyAlertDialog(
            title: "Complete",
            content:
                "The property has been added to the personnel successfully.",
            pageToNavigate: AdminMainPage(),
          );
        });
  }
}
