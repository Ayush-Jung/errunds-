import 'dart:async';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/screens/auth/choose_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSplasScreen extends StatefulWidget {
  const CustomSplasScreen({Key key}) : super(key: key);

  @override
  _CustomSplasScreenState createState() => _CustomSplasScreenState();
}

class _CustomSplasScreenState extends State<CustomSplasScreen> {
  @override
  void initState() {
    firebase.initFirebase();
    Timer(const Duration(seconds: 4), () {
      checkUserStatus();
    });
    super.initState();
  }

  checkUserStatus() {
    firebase.getUserStateListener().listen((event) {
      if (event != null) {}
    });

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const AuthChooser()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: linearGradient,
        ),
        alignment: Alignment.center,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          children: [
            const Spacer(),
            SvgPicture.asset(
              "assets/logo-errunds.svg",
              color: Colors.red[400],
              height: size.height * 0.2,
              width: size.width * 0.2,
            ),
            errunds,
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
