// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/home/decisiontree.dart';
import 'package:project/login_signup/signup.dart';
import 'package:project/Services/auth.dart';

import '../Home/HomePage.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthService _auth = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String e = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  Future<dynamic> validation() async {
    dynamic result = await _auth.loginWithEmail(email, password);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      height: 600,
      width: 400,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 187, 112, 230).withOpacity(1),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Text(
                "Login",
                style: TextStyle(fontSize: 40, fontFamily: "Poppins"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                width: 250,
                child: TextFormField(
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Enter a correct email';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    email = value;
                  }),
                  decoration: const InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SizedBox(
                width: 250,
                child: TextFormField(
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Enter a correct Password';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {
                    password = value;
                  }),
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: SizedBox(
                width: 250,
                child: Text(
                  e,
                  style: const TextStyle(color: Colors.red, fontSize: 10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = validation();
                        if (result == null) {
                          setState(() {
                            e = "Wrong Email or Passowrd";
                          });
                        } else {
                          setState(() {
                            e = "";
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Logged In!")));
                        }
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 17),
                    ),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 7.0),
                    child: (Text("Don't have an account?",
                        style: TextStyle(fontSize: 10, color: Colors.white)))),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 7.0),
                    child: Text(
                      " Click here!",
                      style: TextStyle(
                          fontSize: 10, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
