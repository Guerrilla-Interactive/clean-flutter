import 'package:flutter/material.dart';
import 'package:gskinner/command.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;

  void _handleRefreshPressed() async {
    setState(() {
      _isLoading = true;
    });
    bool success = await LoginCommand().run("someuser", "somepass");

    // Loading is false is login is not successful
    // If login is successful user is taken to home page!
    if (!success) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: _isLoading
          ? const CircularProgressIndicator()
          : TextButton(
              onPressed: _handleRefreshPressed,
              child: const Text("Login"),
            ),
    ));
  }
}
