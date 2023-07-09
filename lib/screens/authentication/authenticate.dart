import 'package:firebase_auth_app/screens/authentication/login.dart';
import 'package:firebase_auth_app/screens/authentication/register.dart';
import 'package:flutter/material.dart';

//create this as stateful widgeet

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  bool signInPage = true;

  void switchPages() {
    setState(() {
      signInPage = !signInPage;
    });
  }

  Widget build(BuildContext context) {
    if (signInPage == true) {
      return SignIn(
        toggle: switchPages,
      );
    } else {
      return Register(
        toggle: switchPages,
      );
    }
  }
}
