import 'package:flutter/material.dart';
import 'package:inventory_demo/MyWidgets/myAppBar.dart';
import '../../MyWidgets/myAlertDialog.dart';
import '../../Services/userService.dart';
import 'directWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = "", password = "";

  @override
  void initState() {
    super.initState();
  }

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
      onSubmitted: (value) {
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
      onSubmitted: (value) {
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
            : () async {
                await _loginWithUsernamePassword(username, password);
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
      String username, String password) async {
    var formState = formKey.currentState;
    if (formState!.validate()) {
      formState.save();

      await UserService().userLogin(username, password).then((userData) {
        if (userData is String) {
          _alertError(userData);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Direct(user: userData)),
              (route) => false);
        }
      });
    }
  }

  void _alertError(String content) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(title: "Error", content: content);
        });
  }
}
