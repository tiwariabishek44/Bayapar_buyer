import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> signUpWithPhoneAndPassword(String phoneNumber, String password) async {
  try {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.createUserWithEmailAndPassword(email: "$phoneNumber@myapp.com", password: password);
    // If the user signs up successfully, you can show a toast message to inform them.
    Fluttertoast.showToast(msg: "Sign up successful!");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Fluttertoast.showToast(msg: "The password provided is too weak.");
    } else if (e.code == 'email-already-in-use') {
      Fluttertoast.showToast(msg: "The account already exists for that phone number.");
    } else {
      print(e.toString());
    }
  } catch (e) {
    print(e.toString());
  }
}