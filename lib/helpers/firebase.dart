import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errunds_application/models/customer_Models/customer.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/rider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class _FirebaseHelper {
  FirebaseAuth _auth;
  FirebaseFirestore _firestore;
  User _user;
  bool trueUser = false;
  UserCredential userCredential;
  Rider rider;
  Customer customer;

  initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
  }

  get currentUser => _auth.currentUser?.uid;

  Future loginUser(email, password,
      {String companyId, bool canLogin = false}) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    userCredential = result;
    return checkUserStatus(result.user, companyId, canLogin);
  }

  Future<bool> checkUserStatus(
      User user, String companyId, bool canLogin) async {
    if (companyId == null) {
      try {
        var customer =
            await _firestore.collection("customers").doc(user.uid).get();
        trueUser = Customer.fromMap(customer.data()).isCustomer;
      } catch (e) {
        trueUser = false;
      }
    } else if (canLogin) {
      try {
        var rider = await _firestore.collection("riders").doc(user.uid).get();
        trueUser = Customer.fromMap(rider.data()).isCustomer;
        trueUser = !trueUser;
      } catch (e) {
        trueUser = false;
      }
    } else {
      trueUser = false;
    }
    if (!trueUser) {
      logOut();
    }

    return trueUser;
  }

  getUserInfo() async {
    try {
      var user =
          await _firestore.collection("customers").doc(currentUser).get();
      return Customer.fromMap(user.data());
    } catch (e) {
      return null;
    } finally {
      try {
        var user = await _firestore.collection("riders").doc(currentUser).get();
        // ignore: control_flow_in_finally
        return Rider.fromMap(user.data());
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }

  Future signupUser(
    String email,
    String password,
    String phoneNumber,
    String fName,
    String lName, {
    String companyId,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        _user = result.user;
        if (companyId != null) {
          await setRider(companyId, phoneNumber, fName, lName);
        } else {
          await setCustomer(phoneNumber, fName, lName);
        }
        return result.user;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> setCustomer(
    String phoneNumber,
    String fName,
    String lName,
  ) async {
    await _firestore.collection("customers").doc(_user.uid).set({
      "email": _user.email,
      "id": _user.uid,
      "fname": fName,
      "lName": lName,
      "phoneNumber": phoneNumber,
      "isAcceptTerms": true,
      "isCustomer": true,
    }, SetOptions(merge: true));
  }

  Future<void> setRider(
    String companyId,
    String phoneNumber,
    String fName,
    String lName,
  ) async {
    await _firestore.collection("riders").doc(_user.uid).set({
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

  Future<Customer> getCustomerInfo({String customerId}) async {
    var customer =
        await _firestore.collection("customers").doc(customerId).get();
    return Customer.fromMap(customer.data());
  }
}

final firebase = _FirebaseHelper();
