import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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
    return result.user;
  }

  Future customerSignUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        _user = result.user;
        await setCustomer();
        return result.user?.uid;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future riderSignUp(String email, String password, String companyId) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        _user = result.user;
        await setRider(companyId);
        return result.user?.uid;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  setCustomer() async {
    await _firestore.collection("customer").doc(_user.uid).set({
      "email": _user.email,
      "id": _user.uid,
      "name": _user.displayName,
    }, SetOptions(merge: true));
  }

  setRider(String companyId) async {
    await _firestore.collection("rider").doc(_user.uid).set({
      "email": _user.email,
      "id": _user.uid,
      "name": _user.displayName,
      "companyId": companyId
    }, SetOptions(merge: true));
  }

  Stream<User> getUserStateListener() {
    return _auth.authStateChanges();
  }
}

final firebase = _FirebaseHelper();
