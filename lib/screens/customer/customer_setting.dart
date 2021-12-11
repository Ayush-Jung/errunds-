import 'package:errunds_application/custom_item/custom_container.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/screens/auth/choose_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerSettingScreen extends StatefulWidget {
  const CustomerSettingScreen({Key key, this.active}) : super(key: key);
  final bool active;

  @override
  _CustomerSettingScreenState createState() => _CustomerSettingScreenState();
}

class _CustomerSettingScreenState extends State<CustomerSettingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/logo-errunds.svg",
                      color: Colors.red[300],
                      height: size.height * 0.2,
                      width: size.width * 0.2,
                    ),
                    errunds,
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.65,
                decoration: BoxDecoration(
                  color: buttonBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "About us ",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "E-rrunds application is a bridge between the customer and Rider where customer search for rider to do some work like parcel Delivery, postal service , pay Bils and so on. ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    CustomContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "PROJECT BY:",
                            style: textStyle,
                          ),
                          Text(
                            "AREOLA, VENUS KATE C",
                            style: textStyle,
                          ),
                          Text(
                            "AURELIO, PATRICIA C",
                            style: textStyle,
                          ),
                          Text(
                            "DAGUYO, ABIGAIL P",
                            style: textStyle,
                          ),
                          Text(
                            "DAHULORAN VASIL JAY-AR S",
                            style: TextStyle(
                                color: buttonBackgroundColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "DIANA, NIKKI LOUSIE T",
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomContainer(
                      child: Column(
                        children: [
                          Text(
                            "Developed by: AYUSH JUNG KARKI",
                            style: TextStyle(
                                color: buttonBackgroundColor, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "VERSION: 1.0",
                            style: TextStyle(
                                color: buttonBackgroundColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12),
                            child: ElevatedButton(
                              onPressed: () async {
                                await firebase.logOut().then((value) =>
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const AuthChooser()),
                                        (route) => false));
                              },
                              child: const Text("Log-out"),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle textStyle = TextStyle(
    color: buttonBackgroundColor, fontSize: 18, fontWeight: FontWeight.bold);
