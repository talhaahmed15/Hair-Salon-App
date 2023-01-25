import 'package:flutter/material.dart';
import 'package:project/home/decisiontree.dart';
import 'package:project/home/homepage.dart';
import 'package:project/login_signup/login.dart';
import 'package:project/Services/auth.dart';
import 'package:project/Shared/loading.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();

  String username = '';
  String email = '';
  String password = '';
  String cpassword = '';

  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  Future<dynamic> validation() async {
    dynamic result = await _auth.registerWithEmail(username, email, password);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            body: Center(
                child: Container(
                    height: 600,
                    width: 400,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 187, 112, 230)
                            .withOpacity(1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 40),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 40, fontFamily: "Poppins"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: SizedBox(
                                width: 250,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter a username';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => setState(() {
                                    username = value;
                                  }),
                                  decoration: const InputDecoration(
                                      labelText: 'Username',
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: SizedBox(
                                width: 250,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter a correct email';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => setState(() {
                                    email = value;
                                  }),
                                  decoration: const InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: SizedBox(
                                width: 250,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter a correct email';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) => setState(() {
                                    password = value;
                                  }),
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      labelText: 'Password',
                                      border: OutlineInputBorder()),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        dynamic result = validation();
                                        if (result == null) {
                                          setState(() {
                                            error = 'Enter a valid Email';
                                          });
                                        } else {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()));
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black),
                                    child: const Text(
                                      "Create Account",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  )),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(top: 7.0),
                                    child: Text("Already have an account?",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white))),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 7.0),
                                    child: Text(
                                      " Click here!",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ]),
                    ))),
          );
  }
}
