import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class _FirebaseHelper {
  FirebaseAuth _auth;
  FirebaseFirestore _firestore;
  User _user;
  bool trueUser = false;
  UserCredential userCredential;
  ErrundUser errundUser;

  initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
  }

  get currentUser => _auth?.currentUser?.uid;

  Future loginUser(
    email,
    password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      getUserInfo();
      return result.user;
    } catch (e) {
      print(e);
    }
  }

  Future setService(Service service) {
    var ref = _firestore
        .collection("Users")
        .doc(currentUser)
        .collection("Services")
        .doc(service.id);
    //it detects for update or new service.
    service.id = ref.id;
    ref.set(service.toMap(), SetOptions(merge: true));
  }

  getRealTimeServices(Function(List<Service>) callBack) {
    _firestore
        .collection("Users")
        .doc()
        .collection("Services")
        .where("lookForRider", isEqualTo: true)
        .snapshots()
        .listen((event) {
      callBack(event.docs
          .map(
            (e) => Service.fromMap(e.data()),
          )
          .toList());
    });
  }

  Future<List<ErrundUser>> getOnlineRiders() async {
    var onlineRiders = await _firestore
        .collection("Users")
        .where("onlineRider", isEqualTo: true)
        .get();
    return onlineRiders.docs
        .map(
          (e) => ErrundUser.fromMap(
            e.data(),
          ),
        )
        .toList();
  }

  Future<ErrundUser> getUserInfo() async {
    try {
      var user = await _firestore.collection("Users").doc(currentUser).get();
      errundUser = ErrundUser.fromMap(user.data());
      return errundUser;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();

    print("logged out");
  }

  Future signupUser(
    String email,
    String password,
    String phoneNumber,
    String fName,
    String lName, {
    String companyId,
    bool isRider = false,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        _user = result.user;
        await setErrrundUser(phoneNumber, fName, companyId, lName,
            isRider: isRider);
        getUserInfo();
        return result.user;
      }
    } catch (e) {}
  }

  Future<void> setErrrundUser(
    String phoneNumber,
    String fName,
    String companyId,
    String lName, {
    bool isRider = false,
  }) async {
    await _firestore.collection("Users").doc(_user.uid).set({
      "email": _user.email,
      "id": _user.uid,
      "fName": fName,
      "lName": lName,
      "phoneNumber": phoneNumber,
      "companyId": companyId,
      "conditionAccepted": true,
      "isRider": isRider,
    }, SetOptions(merge: true));
  }

  Stream<User> getUserStateListener() {
    return _auth.authStateChanges();
  }
}

final firebase = _FirebaseHelper();
