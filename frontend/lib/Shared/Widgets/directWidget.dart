import 'package:flutter/material.dart';
import 'package:inventory_demo/Admin/mainPage.dart';
import 'package:inventory_demo/Personnel/mainPage.dart';
import 'package:inventory_demo/Services/userService.dart';
import '../../Models/User.dart';
import 'loginPage.dart';

class Direct extends StatelessWidget {
  final User? user;

  const Direct({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user == null
          ? FutureBuilder<User?>(
              future: UserService().getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                }

                if (snapshot.hasData) {
                  return _navigateToPage(snapshot.data);
                }

                return const LoginPage();
              },
            )
          : _navigateToPage(user),
    );
  }

  Widget _navigateToPage(User? user) {
    if (user!.roleID == 1) {
      return const AdminMainPage();
    } else {
      return PersonnelMainPage(user: user);
    }
  }
}
