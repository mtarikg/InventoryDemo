import 'package:flutter/material.dart';

import '../MyWidgets/myAppBar.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "My Properties",
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text("Profile Page"),
      ),
    );
  }
}