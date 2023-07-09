import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/description.dart';
import '../../constants/styles.dart';
import '../../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggle;
  const Register({super.key, required this.toggle});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //ref for the AuthService class
  final AuthServices _auth = AuthServices();

  //create a global key for identifying the form uniquely
  final _formKey = GlobalKey<FormState>();

  // email password states
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgBlack,
        appBar: AppBar(
          title: const Text("REGISTER"),
          backgroundColor: bgBlack,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                // description
                const Text(
                  description,
                  style: descriptionStyle,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/man.png',
                    height: 150,
                    width: 150,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // email
                          TextFormField(
                            style: const TextStyle(color: textLight),
                            decoration: textInputtDecorations,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => value == null ||
                                    value.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)
                                ? "Enter a valid email"
                                : null,
                            onChanged: (value) => setState(() {
                              email = value;
                            }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // password
                          TextFormField(
                            obscureText: true,
                            style: const TextStyle(color: textLight),
                            decoration: textInputtDecorations.copyWith(
                                hintText: "Password"),
                            validator: (value) {
                              if (value!.length < 8) {
                                return "Password should consist at least 8 characters";
                              }

                              if (value.isEmpty) {
                                return "Please enter a password";
                              }

                              return null;
                            },
                            onChanged: (value) => setState(() {
                              password = value;
                            }),
                          ),
                          // display error
                          const SizedBox(height: 10),
                          Text(
                            error,
                            style: const TextStyle(color: Colors.red),
                          ),
                          // google
                          const SizedBox(height: 20),
                          const Text(
                            "Login with social accounts",
                            style: descriptionStyle,
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                'assets/images/google.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          // register
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: descriptionStyle,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.toggle();
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(color: mainBlue),
                                ),
                              )
                            ],
                          ),
                          // button
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);

                              if (result == null) {
                                setState(() {
                                  error = "Please enter valid email";
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: mainYellow),
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Center(
                                child: Text(
                                  "REGISTER",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
