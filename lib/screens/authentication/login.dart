import 'package:firebase_auth_app/constants/colors.dart';
import 'package:firebase_auth_app/constants/description.dart';
import 'package:firebase_auth_app/constants/styles.dart';
import 'package:firebase_auth_app/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;

  const SignIn({super.key, required this.toggle});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
          title: const Text("SIGN IN"),
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
                              onTap: () async {
                                dynamic result = await _auth.signInWithGoogle();
                                if (result == null) {
                                  setState(() {
                                    error =
                                        "Error sign in with your google account";
                                  });
                                }
                              },
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
                                "Don't have an account?",
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
                                  "Register",
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
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);

                              if (result == null) {
                                setState(() {
                                  error = "Invalid credentials";
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
                                  "LOGIN",
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
                          GestureDetector(
                            onTap: () async {
                              dynamic result = await _auth.signInAnonymous();
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: mainBlue),
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Center(
                                child: Text(
                                  "LOGIN AS GUEST",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                          // anon
                        ],
                      )),
                )
              ],
            ),
          ),
        ));
  }
}


// ElevatedButton(
//         child: const Text("Sign in Anonymously"),
//         onPressed: () async {
//           dynamic result = await _auth.signInAnonymous();
//           if (result == null) {
//             print("signed in failed");
//           } else {
//             print("signed in");
//             print(result.uid);
//           }
//         },
//       ),
