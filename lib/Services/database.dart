import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/Models/cart.dart';
import 'package:project/Models/customer.dart';
import 'package:project/Models/shop_item.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userData =
      FirebaseFirestore.instance.collection('Customers');

  final CollectionReference itemData =
      FirebaseFirestore.instance.collection('Shop Items');

  final CollectionReference cartData = FirebaseFirestore.instance
      .collection('Customers')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Cart');

  final CollectionReference bookingData = FirebaseFirestore.instance
      .collection('Customers')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('Bookings');

  Future updateUserData(String name, String email, String password) async {
    return await userData
        .doc(uid)
        .set({'username': name, 'email': email, 'password': password});
  }

  Future updateBookingData(String gender, String service, String description,
      String beautician, String time, String date) async {
    return await bookingData.doc(uid).set({
      'gender': gender,
      'service': service,
      'description': description,
      'beautician': beautician,
      'date': date,
      'time': time
    });
  }

  Future updateCartData(String name, String price, int quantity) async {
    return await cartData.doc().set({
      'Item': [name, price, quantity]
    });
  }

  CustomerData _customerFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      return CustomerData(
          name: document.get('username') ?? " ",
          email: document.get('email') ?? " ",
          password: document.get('password') ?? " ");
    }).first;
  }

  Stream<CustomerData> get customers {
    return userData.snapshots().map(_customerFromSnapshot);
  }

  List<ShopItem> _itemFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      return ShopItem(
          name: document.get('name') ?? "",
          price: document.get('price') ?? "",
          description: document.get('Description'));
    }).toList();
  }

  Stream<List<ShopItem>> get items {
    return itemData.snapshots().map(_itemFromSnapshot);
  }

  Stream<List<Cart>> get cart {
    return cartData.snapshots().map(_cartFromSnapshot);
  }

  List<Cart> _cartFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((document) {
      return Cart(
          name: document.get('name') ?? "",
          price: document.get('price') ?? "",
          quantity: document.get('quantity') ?? "");
    }).toList();
  }
}
