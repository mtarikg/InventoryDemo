import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myCategoryDropdown.dart';
import '../MyWidgets/myAppBar.dart';
import 'mainPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
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
        children: const [SelectCategoryDropdown()],
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
