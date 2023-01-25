import 'package:flutter/material.dart';
import 'package:project/Models/shop_item.dart';
import 'package:project/Services/auth.dart';
import 'package:project/Services/database.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ShopItem>?>.value(
        value: DatabaseService().items,
        initialData: const [],
        child: const ItemCard());
  }
}

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<ShopItem>?>(context);
    final length = items?.length;
    List quantity = List<int>.filled(length!, 0);
    return Scaffold(
        body: Card(items: items, length: length, quantity: quantity));
  }
}

class Card extends StatefulWidget {
  Card({
    required this.items,
    required this.length,
    required this.quantity,
    Key? key,
  }) : super(key: key);

  final items;
  final length;
  List quantity;

  @override
  State<Card> createState() => _CardState();
}

class _CardState extends State<Card> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              addAutomaticKeepAlives: false,
              itemCount: widget.items!.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 153, 135, 135),
                        border: Border.all(width: 2, color: Colors.black),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 0, 0, 0),
                            offset: Offset(1.0, 3.0), //(x,y)
                            blurRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 2, right: 2),
                            child: Icon(
                              Icons.auto_awesome_sharp,
                              size: 30,
                              color: Color.fromARGB(255, 236, 211, 64),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2, 3, 0, 3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LimitedBox(
                                  maxWidth: 240,
                                  child: Text(
                                    widget.items[index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 17, fontFamily: 'Poppins'),
                                  ),
                                ),
                                LimitedBox(
                                  maxHeight: 100,
                                  maxWidth: 220,
                                  child: Text(
                                    widget.items[index].description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'Poppins-light'),
                                  ),
                                ),
                                Text(
                                  "${widget.items[index].price} \$",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Poppins-light',
                                      color: Color.fromARGB(255, 236, 211, 64)),
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  widget.quantity[index]++;
                                });
                              },
                              child: const Icon(
                                Icons.add,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Text(widget.quantity[index].toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  widget.quantity[index]--;
                                });
                              },
                              child: const Icon(
                                Icons.remove,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              })),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 20),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  for (int element = 0; element < widget.length; element++) {
                    if (widget.quantity[element] > 0) {
                      AuthService().addtoCart(
                          widget.items[element].name,
                          widget.items[element].price,
                          widget.quantity[element]);
                    }
                  }

                  if (!widget.quantity
                      .every((element) => widget.quantity[element] == 0)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Items Added!")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Cart is Empty")));
                  }

                  setState(() {
                    for (var element in widget.quantity) {
                      widget.quantity[element] = 0;
                    }
                  });
                },
                child: const Text(
                  "Add to cart",
                  style: TextStyle(
                    fontFamily: 'Poppins-light',
                    fontSize: 20,
                  ),
                )),
          ),
        )
      ],
    );
  }
}
