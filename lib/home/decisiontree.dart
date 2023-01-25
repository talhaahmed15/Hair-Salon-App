import 'package:flutter/material.dart';
import 'package:project/Home/HomePage.dart';
import 'package:project/login_signup/login.dart';
import 'package:provider/provider.dart';

import '../Models/customer.dart';

class DecisionTree extends StatelessWidget {
  const DecisionTree({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<Customer?>(context);

    if (customer == null) {
      return const LogIn();
    } else {
      return const HomePage();
    }
  }
}
