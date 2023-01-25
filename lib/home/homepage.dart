// ignore: depend_on_referenced_packages
// ignore_for_file: file_names

// ignore: depend_on_referenced_packages

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:project/Models/customer.dart';
import 'package:project/Services/auth.dart';
import 'package:project/Services/database.dart';
import 'package:project/home/account.dart';
import 'package:project/home/shop.dart';
import 'package:project/home/welcome_text.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  _HomePageState();

  String dropdownValue = 'Male';
  String dropdownValue2 = 'Haircut';
  String dropdownValue3 = 'Sehrish';

  DateTime datern = DateTime.now();
  TimeOfDay time = const TimeOfDay(hour: 00, minute: 00);
  final TextEditingController _descController = TextEditingController();

  void dropdown(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownValue = selectedValue;
      });
    }
  }

  void dropdown2(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownValue2 = selectedValue;
      });
    }
  }

  void dropdown3(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownValue3 = selectedValue;
      });
    }
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: datern,
            firstDate: datern,
            lastDate: DateTime(2030))
        .then((value) {
      setState(() {
        datern = value!;
      });
    });
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final mins = time.minute.toString().padLeft(2, '0');

    return MultiProvider(
        providers: [
          StreamProvider<CustomerData?>.value(
              value: DatabaseService().customers,
              initialData: Provider.of<CustomerData?>(context)),
        ],
        child: Scaffold(
            appBar: AppBar(
              title: const WelcomeText(),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 46, 231, 222)),
                    child: const Text("Sign Out"),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    })
              ],
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: currentPageIndex,
              onDestinationSelected: ((value) {
                setState(() {
                  currentPageIndex = value;
                });
              }),
              destinations: const [
                NavigationDestination(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: "Home"),
                NavigationDestination(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: "Shop"),
                NavigationDestination(
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                  label: "Account",
                ),
              ],
              backgroundColor: Colors.black,
            ),
            body: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Gender Box
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Gender:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Poppins-light',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: DropdownButton(
                            items: const [
                              DropdownMenuItem(
                                  value: "Male",
                                  child: Padding(
                                    padding: EdgeInsets.all(3),
                                    child: Text(
                                      "Male",
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'Poppins'),
                                    ),
                                  )),
                              DropdownMenuItem(
                                value: "Female",
                                child: Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Text(
                                    "Female",
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'Poppins'),
                                  ),
                                ),
                              )
                            ],
                            value: dropdownValue,
                            onChanged: dropdown,
                            isExpanded: true,
                            underline: Container(),
                          ),
                        ),
                      ),

                      //Services Box
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Services:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Poppins-light',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: DropdownButton(
                            items: const [
                              DropdownMenuItem(
                                value: "Haircut",
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    "Haircut",
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                  value: "Wax",
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      "Wax",
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'Poppins'),
                                    ),
                                  )),
                              DropdownMenuItem(
                                value: "Spa",
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Spa",
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'Poppins'),
                                  ),
                                ),
                              )
                            ],
                            value: dropdownValue2,
                            onChanged: dropdown2,
                            isExpanded: true,
                            underline: Container(),
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Describe your service: ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Poppins-light',
                            fontSize: 20,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      TextField(
                        controller: _descController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Colors.amber), //<-- SEE HERE
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        maxLength: 500,
                      ),

                      //DATE Box
                      const Text(
                        "Booking Date:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Poppins-light',
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: InkWell(
                            onTap: _showDatePicker,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.date_range,
                                  size: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    DateFormat('dd-MM-yyyy').format(datern),
                                    style: const TextStyle(
                                        fontSize: 18, fontFamily: 'Poppins'),
                                  ),
                                )
                              ],
                            ),
                          )),

                      //Time Box
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Booking Time:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Poppins-light',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: InkWell(
                            onTap: () async {
                              TimeOfDay? newTime = await showTimePicker(
                                  context: context, initialTime: time);
                              if (newTime == null) return;

                              setState(() {
                                time = newTime;
                              });
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '$hours : $mins',
                                    style: const TextStyle(
                                        fontSize: 18, fontFamily: 'Poppins'),
                                  ),
                                )
                              ],
                            ),
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          "Beautician:",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Poppins-light',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DropdownButton(
                            items: const [
                              DropdownMenuItem(
                                  value: "Sehrish",
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Sehrish",
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'Poppins'),
                                    ),
                                  )),
                              DropdownMenuItem(
                                value: "Ayesha",
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Ayesha",
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Aneesa",
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Aneesa",
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: 'Poppins'),
                                  ),
                                ),
                              )
                            ],
                            value: dropdownValue3,
                            onChanged: dropdown3,
                            isExpanded: true,
                            underline: Container(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              AuthService().bookAppointment(
                                  dropdownValue,
                                  dropdownValue2,
                                  _descController.text.trim(),
                                  dropdownValue3,
                                  time.toString(),
                                  DateFormat('dd-MM-yyyy').format(datern));

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Appointment Booked!")));
                            },
                            child: const Text(
                              "Book Now",
                              style: TextStyle(
                                fontFamily: 'Poppins-light',
                                fontSize: 20,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              const ShopPage(),
              const Account()
            ][currentPageIndex]));
  }
}
