// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/Models/customer.dart';
import 'package:project/Services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService dbs = DatabaseService();

  Stream<Customer?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Customer? _userFromFirebaseUser(User? user) {
    return user != null ? Customer(uid: user.uid) : null;
  }

  Future loginWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      return null;
    }
  }

  Future registerWithEmail(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid)
          .updateUserData(name, email, password);
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  Future bookAppointment(String gender, String service, String description,
      String beautician, String time, String date) async {
    try {
      User? user = _auth.currentUser;
      await DatabaseService(uid: user!.uid).updateBookingData(
          gender, service, description, beautician, time, date);
    } catch (e) {
      return null;
    }
  }

  Future addtoCart(String name, String price, int quantity) async {
    await DatabaseService().updateCartData(name, price, quantity);
  }
}
