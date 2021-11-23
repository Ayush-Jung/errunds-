import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errunds_application/models/customer_Models/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class _FirebaseHelper {
  FirebaseAuth _auth;
  FirebaseFirestore _firestore;
  User _user;

  initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
  }

  get currentUser => _auth.currentUser?.uid;

  Future customerLogin(email, password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return checkUserStatus(result.user);
  }

  Future<bool> checkUserStatus(User user) async {
    var customer = await _firestore.collection("customer").doc(user.uid).get();
    return Customer.fromMap(customer.data()).isCustomer;
  }

  Future customerSignUp(
      String email,
      String password,
      String companyId,
      String phoneNumber,
      String fName,
      String lName,
      bool isAcceptTerms) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        _user = result.user;
        await setCustomer(phoneNumber, fName, lName);
        return result.user?.uid;
      }
    } catch (e) {
      print(e.toString());
      print("unable to sign up ");
    }
  }

  Future riderSignUp(String email, String password, String companyId,
      String phoneNumber, String fName, String lName) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        _user = result.user;
        await setRider(companyId, phoneNumber, fName, lName);
        return result.user?.uid;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  setCustomer(
    String phoneNumber,
    String fName,
    String lName,
  ) async {
    await _firestore.collection("customer").doc(_user.uid).set({
      "email": _user.email,
      "id": _user.uid,
      "fname": fName,
      "lName": lName,
      "phoneNumber": phoneNumber,
      "isAcceptTerms": true,
      "isCustomer": true,
    }, SetOptions(merge: true));
  }

  setRider(
    String companyId,
    String phoneNumber,
    String fName,
    String lName,
  ) async {
    await _firestore.collection("rider").doc(_user.uid).set({
      "email": _user.email,
      "id": _user.uid,
      "fName": fName,
      "lName": lName,
      "phoneNumber": phoneNumber,
      "companyId": companyId,
      "acceptTerms": true,
      "isCustomer": false,
    }, SetOptions(merge: true));
  }

  Stream<User> getUserStateListener() {
    return _auth.authStateChanges();
  }
}

final firebase = _FirebaseHelper();
