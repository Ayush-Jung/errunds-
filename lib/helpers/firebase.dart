import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;

class _FirebaseHelper {
  FirebaseAuth _auth;
  FirebaseFirestore _firestore;
  User _user;
  bool trueUser = false;
  UserCredential userCredential;
  ErrundUser errundUser;
  FirebaseStorage _storage;

  initFirebase() async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
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
    service.id = ref.id;
    service.status = ServiceStatus.ACTIVE;
    service.paymentStatus = PaymentStatus.PENDING;
    service.customerId = currentUser;
    ref.set(service.toMap(), SetOptions(merge: true));
    return ref.id;
  }

  StreamSubscription getRealTimeServices(Function(List<Service>) callBack) {
    _firestore
        .collection("services")
        .where(
          "createdDate",
          isGreaterThanOrEqualTo: DateTime.now().subtract(
            Duration(minutes: 30),
          ),
        )
        .snapshots()
        .listen((event) {
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

  Future<List<Service>> getActiveServices({bool isRider}) async {
    var servicesRef = await _firestore
        .collection("services")
        .where("status", isEqualTo: "started");
    if (isRider) {
      servicesRef = servicesRef.where("riderId", isEqualTo: currentUser);
    } else {
      servicesRef = servicesRef.where("customerId", isEqualTo: currentUser);
    }
    QuerySnapshot services = await servicesRef.get();
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

  Future<List<Service>> getCompletedServices({bool isRider}) async {
    var servicesRef = await _firestore
        .collection("services")
        .where("status", isEqualTo: "completed");
    if (isRider) {
      servicesRef = servicesRef.where("riderId", isEqualTo: currentUser);
    } else {
      servicesRef = servicesRef.where("customerId", isEqualTo: currentUser);
    }
    QuerySnapshot services = await servicesRef.get();
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

  StreamSubscription<ErrundUser> getRealTimeUserInfo(
      Function(ErrundUser) callback) {
    try {
      var user = _firestore
          .collection("Users")
          .doc(currentUser)
          .snapshots()
          .listen((event) {
        callback(ErrundUser.fromMap(
          event.data(),
        ));
      });
    } catch (e) {
      print(e);
    }
  }

  Future<ErrundUser> getUserInfo() async {
    try {
      var user = await _firestore.collection("Users").doc(currentUser).get();
      errundUser = ErrundUser.fromMap(user.data());
      return errundUser;
    } catch (e) {
      print(e.message);
    }
  }

  Future<ErrundUser> getUserById({String userId}) async {
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

  Future<void> updateUser(ErrundUser user) async {
    await _firestore.collection("Users").doc(currentUser).update(user.toMap());
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

  Future uploadFile(File image,
      {String path, int quality: 60, int resize = 0}) async {
    var fileName = currentUser + "." + image.path.split(".")[1];
    var ref = _storage.ref().child(path ?? "/profile_pictures/$fileName");
    await ref
        .putFile(await compressImage(image, quality: quality, resize: resize));
    return await ref.getDownloadURL();
  }
}

Future<File> compressImage(file, {int quality = 60, int resize = 0}) async {
  final tempDir = await getTemporaryDirectory();
  final path = tempDir.path;
  int rand = Random().nextInt(10000);
  Im.Image image = Im.decodeImage(file.readAsBytesSync());
  if (resize != 0) {
    image = Im.copyResize(image, width: resize);
  }

  return File('$path/img_$rand.jpg')
    ..writeAsBytesSync(
      Im.encodeJpg(
        image,
        quality: quality,
      ),
    );
}

final firebase = _FirebaseHelper();
