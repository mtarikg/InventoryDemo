import 'package:flutter/material.dart';
import 'package:inventory_demo/Shared/sendRequest.dart';
import 'homePage.dart';
import 'profilePage.dart';

class PersonnelMainPage extends StatefulWidget {
  final int? index;

  const PersonnelMainPage({Key? key, this.index}) : super(key: key);

  @override
  State<PersonnelMainPage> createState() => _PersonnelMainPageState();
}

class _PersonnelMainPageState extends State<PersonnelMainPage> {
  late int _barIndex;

  @override
  void initState() {
    super.initState();
    _barIndex = widget.index ?? 0;
  }

  void _onTapped(int index) {
    setState(() {
      _barIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _barIndex,
      onTap: _onTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More')
      ],
    );
  }

  Widget _body() {
    return IndexedStack(
      index: _barIndex,
      children: const [
        HomePage(),
        ProfilePage(),
        SendRequest(
            title: "Send a Property Request", backgroundColor: Colors.orange)
      ],
    );
  }
}
