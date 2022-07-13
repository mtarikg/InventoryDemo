import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import 'package:inventory_demo/Personnel/mainPage.dart';
import '../Admin/mainPage.dart';

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
        title: "Login",
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
                      LoginButton(
                          username: username,
                          password: password,
                          context: context,
                          formKey: _formKey),
                      TextButton(
                        child: const Text("Proceed as Personnel"),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PersonnelMainPage()),
                              (route) => false);
                        },
                      ),
                      TextButton(
                        child: const Text("Proceed as Admin"),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminMainPage()),
                              (route) => false);
                        },
                      ),
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

class LoginButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
            : () {
                _loginWithUsernamePassword();
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
}

void _loginWithUsernamePassword() {}
