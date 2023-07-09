import 'package:firebase_auth_app/models/UserModel.dart';
import 'package:firebase_auth_app/screens/authentication/authenticate.dart';
import 'package:firebase_auth_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//create the wrapper as a stateless widget

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
