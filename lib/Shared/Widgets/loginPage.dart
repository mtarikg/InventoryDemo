import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_demo/Models/User.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import 'package:inventory_demo/Personnel/mainPage.dart';
import 'package:inventory_demo/Services/apiService.dart';
import '../../Admin/mainPage.dart';
import '../../MyWidgets/myAlertDialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String username = "", password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: "Inventory Demo",
        centerTitle: true,
        backgroundColor: Colors.blue,
        hasLogOutButton: false,
      ),
      body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _usernameTextField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _passwordTextField(),
                      ),
                      const SizedBox(height: 25),
                      LoginButton(
                          username: username,
                          password: password,
                          context: context,
                          formKey: _formKey),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  TextField _passwordTextField() {
    return TextField(
      obscureText: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: "Password",
        hintText: "Please enter your password",
      ),
      onChanged: (value) {
        setState(() {
          password = value.toString();
        });
      },
    );
  }

  TextField _usernameTextField() {
    return TextField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: "Username",
        hintText: "Please enter your username",
      ),
      onChanged: (value) {
        setState(() {
          username = value.toString();
        });
      },
    );
  }
}

class LoginButton extends ConsumerWidget {
  final String username;
  final String password;
  final BuildContext context;
  final GlobalKey<FormState> formKey;

  const LoginButton({
    Key? key,
    required this.username,
    required this.password,
    required this.context,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isUsernameNull = username.isEmpty;
    var isPasswordNull = password.isEmpty;
    var result = isUsernameNull || isPasswordNull;
    var isDisabled = result;

    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 1),
        color: isDisabled ? Colors.grey : Colors.blue,
      ),
      child: TextButton(
        onPressed: isDisabled
            ? null
            : () async {
                await _loginWithUsernamePassword(username, password, ref);
              },
        child: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Future<void> _loginWithUsernamePassword(
      String username, String password, WidgetRef ref) async {
    var formState = formKey.currentState;
    if (formState!.validate()) {
      formState.save();

      await ApiService().userLogin(username, password).then((userData) {
        if (userData is String) {
          _alertError(userData);
        } else {
          User user = _createUser(userData, ref);
          if (user.roleID == 1) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AdminMainPage()),
                (route) => false);
          } else if (user.roleID == 2) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const PersonnelMainPage()),
                (route) => false);
          }
        }
      });
    }
  }

  User _createUser(userData, WidgetRef ref) {
    int id = int.parse(userData[0]);
    int roleID = int.parse(userData[1]);
    User user = User(id: id, roleID: roleID);
    ref.read(userProvider.notifier).addUser(user);
    return user;
  }

  void _alertError(String content) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(title: "Error", content: content);
        });
  }
}
