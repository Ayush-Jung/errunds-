import 'dart:async';

import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/screens/auth/choose_auth.dart';
import 'package:errunds_application/screens/customer/customer_welcome_screen.dart';
import 'package:errunds_application/screens/driver/rider_home_page.dart';
import 'package:errunds_application/screens/driver/rider_welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSplasScreen extends StatefulWidget {
  const CustomSplasScreen({Key key}) : super(key: key);

  @override
  _CustomSplasScreenState createState() => _CustomSplasScreenState();
}

class _CustomSplasScreenState extends State<CustomSplasScreen> {
  ErrundUser errundUser;
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () => checkUserStatus());
    super.initState();
  }

  checkUserStatus() async {
    firebase.getUserStateListener().listen((event) async {
      if (event != null) {
        errundUser = await firebase.getUserInfo();
        if (mounted) setState(() {});
        manageRoute();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const AuthChooser(),
          ),
        );
      }
    });
  }

  manageRoute() {
    if (errundUser != null &&
        (!errundUser.isRider || errundUser.companyId == null)) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const CustomerWelcomeScreen(),
            ),
            (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const RiderWelcomeScreen(),
          ),
          (route) => false);
    }
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
