import 'dart:async';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/home_item.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/screens/auth/choose_auth.dart';
import 'package:errunds_application/screens/customer/customer_welcome_screen.dart';
import 'package:errunds_application/screens/driver/rider_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CustomSplasScreen extends StatefulWidget {
  const CustomSplasScreen({Key key}) : super(key: key);

  @override
  _CustomSplasScreenState createState() => _CustomSplasScreenState();
}

class _CustomSplasScreenState extends State<CustomSplasScreen> {
  HomeItem homeItem;
  ErrundUser errundUser;
  @override
  void initState() {
    getUser();
    Timer(const Duration(seconds: 4), () {
      checkUserStatus();
    });
    super.initState();
  }

  getUser() async {
    errundUser = await firebase.getUserInfo();
    setState(() {});
  }

  checkUserStatus() {
    if (errundUser != null) {
      manageRoute();
    } else {
      {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const AuthChooser(),
            ),
            (route) => false);
      }
    }
  }

  manageRoute() {
    if (!errundUser.isRider) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const CustomerWelcomeScreen(),
          ),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const RiderHomePage(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeItem homeItem = Provider.of<HomeItem>(context);
    homeItem.setContext(context);
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
