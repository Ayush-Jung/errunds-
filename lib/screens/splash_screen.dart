import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/home_item.dart';
import 'package:errunds_application/screens/auth/choose_auth.dart';
import 'package:errunds_application/screens/customer/customer_welcome_screen.dart';
import 'package:errunds_application/screens/driver/rider_home_page.dart';
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
    checkUserStatus();
    super.initState();
  }

  checkUserStatus() async {
    firebase.getUserStateListener().listen((event) async {
      if (event != null) {
        await firebase.getUserInfo();
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
    if (firebase.errundUser != null &&
        (!firebase.errundUser.isRider ||
            firebase.errundUser.companyId == null)) {
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
