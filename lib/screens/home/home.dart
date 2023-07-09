import 'package:firebase_auth_app/constants/colors.dart';
import 'package:firebase_auth_app/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      appBar: AppBar(
          title: const Text("Home"),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: bgBlack),
                onPressed: () async {
                  await AuthServices().signOut();
                },
                child: const Icon(Icons.logout)),
          ],
          backgroundColor: bgBlack),
    );
  }
}
