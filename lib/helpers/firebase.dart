import 'dart:async';

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
      if (result?.user != null) {
        getUserInfo();
        return result.user;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> setService(Service service) async {
    var ref = _firestore.collection("services").doc(service.id);
    //it detects for update or new service.
    service.id = ref.id;
    service.status = ServiceStatus.ACTIVE;
    service.paymentStatus = PaymentStatus.PENDING;
    service.customerId = currentUser;
    ref.set(service.toMap(), SetOptions(merge: true));
    return ref.id;
  }

  getRealTimeServices(Function(List<Service>) callBack) {
    _firestore.collection("services").snapshots().listen((event) {
      List<Service> activeService = [];
      for (var element in event.docs) {
        Service service = Service.fromMap(element.data());
        if (service.status == ServiceStatus.ACTIVE ||
            service.status == ServiceStatus.STARTED) {
          activeService.add(service);
        }
      }
      callBack(activeService);
    });
  }

  Future<List<Service>> getActiveServices() async {
    var services = await _firestore
        .collection("services")
        .where("customerId", isEqualTo: currentUser)
        .where("status", isEqualTo: "started")
        .get();
    return services.docs.map((e) => Service.fromMap(e.data())).toList();
  }

  getServiceById(String serviceId, Function(Service) callback) {
    _firestore
        .collection("services")
        .doc(serviceId)
        .snapshots()
        .listen((event) {
      callback(
        Service.fromMap(
          event.data(),
        ),
      );
    });
  }

  Future<List<Service>> getCompletedServices() async {
    var services = await _firestore
        .collection("services")
        .where("customerId", isEqualTo: currentUser)
        .where("status", isEqualTo: "completed")
        .get();
    return services.docs
        .map(
          (service) => Service.fromMap(service.data()),
        )
        .toList();
  }

  Future lockTheService(String serviceId,
      {ServiceStatus status = ServiceStatus.STARTED}) async {
    try {
      await _firestore.collection("services").doc(serviceId).set({
        "status": getKeyFromServiceStatusType(status),
        "riderId": currentUser,
      }, SetOptions(merge: true));
    } catch (e) {}
  }

  Future<bool> abortService(String serviceId,
      {ServiceStatus status = ServiceStatus.STARTED}) async {
    try {
      await _firestore.collection("services").doc(serviceId).set({
        "status": getKeyFromServiceStatusType(status),
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> unLockTheService(String serviceId) async {
    try {
      await _firestore.collection("services").doc(serviceId).set({
        "paymentStatus": getKeyFromPaymentStatus(PaymentStatus.PAID),
        "status": getKeyFromServiceStatusType(ServiceStatus.COMPLETED),
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<ErrundUser> getUserInfo() async {
    try {
      var user = await _firestore.collection("Users").doc(currentUser).get();
      errundUser = ErrundUser.fromMap(user.data());
      return errundUser;
    } catch (e) {
      print(e);
    }
  }

  Future<ErrundUser> getUserById(String userId) async {
    try {
      var user = await _firestore.collection("Users").doc(userId).get();
      return ErrundUser.fromMap(user.data());
    } catch (e) {
      print(e.message);
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
