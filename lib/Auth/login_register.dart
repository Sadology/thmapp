import 'package:flutter/material.dart';
import 'package:thm/pages/loginPage.dart';
import 'package:thm/pages/registerPage.dart';

class Login_Register extends StatefulWidget {
  const Login_Register({super.key});

  @override
  State<Login_Register> createState() => _Login_RegisterState();
}

class _Login_RegisterState extends State<Login_Register> {
  bool showLoginPage = true;

  void toggle() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: toggle);
    } else {
      return RegisterPage(onTap: toggle);
    }
  }
}
