import 'package:flutter/material.dart';
import 'package:project/Models/customer.dart';
import 'package:provider/provider.dart';

class WelcomeText extends StatefulWidget {
  const WelcomeText({super.key});

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  @override
  Widget build(BuildContext context) {
    final customers = Provider.of<CustomerData?>(context);

    return Text(
      "Welcome  ${customers?.name}",
      style: const TextStyle(fontFamily: 'Font2', fontSize: 25),
    );
  }
}
