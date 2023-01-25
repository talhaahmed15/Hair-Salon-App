import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/Models/customer.dart';
import 'package:project/Services/auth.dart';
import 'package:project/home/decisiontree.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(StreamProvider<Customer?>.value(
    initialData: null,
    value: AuthService().user,
    child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor:
                const Color.fromARGB(255, 187, 112, 230).withOpacity(1),
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.black, primary: Colors.black),
            inputDecorationTheme: const InputDecorationTheme(
                errorStyle: TextStyle(color: Color.fromARGB(255, 201, 26, 26)),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: Color.fromARGB(255, 100, 208, 223)),
                ))),
        home: const DecisionTree()),
  ));
}
