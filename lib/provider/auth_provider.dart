//Register vendor using email

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? email;
  String error = '';

  Future<UserCredential> registeremploye(email, password) async {
    // this.email = email;
    notifyListeners();
    UserCredential? userCredential;
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
        notifyListeners();
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
        notifyListeners();
        // print('The account already exists for that email.');
      }
    } catch (e) {
      error = e.toString();
      notifyListeners();
      print(e);
    }
    return userCredential!;
  }

  //login Employee using email
  Future<UserCredential> loginemploye(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      error = e.code;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
      // print(e);
    }
    return userCredential!;
  }

  //  Save Employee data to firestore
  Future<void> saveEmployeeDataToDb({String? employedID}) {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference _employee =
        FirebaseFirestore.instance.collection('employees').doc(user!.uid);

    _employee.set({
      'uid': user.uid,
      'email': email,
      'employeId': employedID //keep initial value as false
    });
    return null!;
  }
}
