import 'package:errunds_application/custom_item/custom_container.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/screens/auth/choose_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key, this.active}) : super(key: key);
  final bool active;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                decoration: BoxDecoration(
                  color: secondaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "About us ",
                        style: TextStyle(
                            fontSize: 26,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        """In these times, it is evident that the people in the society constantly battle hectic schedules and time-consuming execution of work-related activities that take much of the limited number of hours a day. However, due to demanding workload and obligations, most people cannot incorporate work with daily personal affairs thus, being unable to: pay water and electric utilities, purchase necessaries, deliver items, or pick up products. 
E-RRUNDS is an errand service, a privately-held partnership of the researchers: Venus Kate Areola, Patricia Aurelio, Abigail Daguyo, Vasil Jay-ar Dahuloran, and Nikki Louise Diana. E-RRUNDS offers to do the errands people cannot perform in the meantime; it has runners (riders) who will perform essential errand services that the customers cannot attend.Basic errand services include grocery shopping, personal shopping, paying bills, picking up laundry, food delivery, mailing a package, and dropping some items to different stores. E-RRUNDS cater to customers of all ages who cannot do their errands because they are too busy, do not have enough time, or are frustrated with the hassle of the protocols brought by the COVID-19 pandemic. Thanks to E-RRUNDS, busy people can focus on their job instead of monotonous activities.
""",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    CustomContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                color: secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "DIANA, NIKKI LOUISE T",
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    CustomContainer(
                      child: Column(
                        children: [
                          Text("Developed by: AYUSH JUNG KARKI",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "VERSION: 1.0",
                            style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(secondaryColor),
                              ),
                              onPressed: () async {
                                await firebase.logOut().then((value) =>
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const AuthChooser()),
                                        (route) => false));
                              },
                              child: Text(
                                "Log-out",
                                style: TextStyle(color: primaryColor),
                              ),
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

TextStyle textStyle =
    TextStyle(color: secondaryColor, fontSize: 16, fontWeight: FontWeight.bold);
