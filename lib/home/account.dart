import 'package:flutter/material.dart';
import 'package:project/Models/cart.dart';
import 'package:project/Models/customer.dart';
import 'package:project/Services/database.dart';
import 'package:provider/provider.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<CustomerData?>.value(
            value: DatabaseService().customers,
            initialData: Provider.of<CustomerData?>(context),
          ),
          StreamProvider<List<Cart>?>.value(
              value: DatabaseService().cart, initialData: const [])
        ],
        child: const Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Your Info",
                      style: TextStyle(fontSize: 30, fontFamily: "Poppins"),
                    ),
                  ),
                  First()
                ],
              ),
            ),
          ),
        ));
  }
}

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomerData>(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.only(top: 10),
        child: SizedBox(
          width: 250,
          child: Text(
            "Name",
            style: TextStyle(fontSize: 15, fontFamily: "Poppins"),
          ),
        ),
      ),
      Text(
        user.name,
        style: const TextStyle(fontSize: 20, fontFamily: "Poppins-light"),
      ),
      const Divider(
        height: 30,
        color: Colors.black,
        endIndent: 10,
      ),
      const SizedBox(
        width: 250,
        child: Text(
          "Email",
          style: TextStyle(fontSize: 15, fontFamily: "Poppins"),
        ),
      ),
      Text(
        user.email,
        style: const TextStyle(fontSize: 20, fontFamily: "Poppins-light"),
      ),
      const Divider(
        height: 30,
        color: Colors.black,
        endIndent: 10,
      ),
      const SizedBox(
        width: 250,
        child: Text(
          "Cart",
          style: TextStyle(fontSize: 15, fontFamily: "Poppins"),
        ),
      ),
      const Text(
        '',
        style: TextStyle(fontSize: 20, fontFamily: "Poppins-light"),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SizedBox(
            width: 100,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text(
                "Sign Out",
                style: TextStyle(fontSize: 17),
              ),
            )),
      ),
    ]);
  }
}
