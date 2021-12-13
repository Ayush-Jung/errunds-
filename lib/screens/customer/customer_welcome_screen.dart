import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/screens/customer/customer_home_screen.dart';
import 'package:errunds_application/screens/customer/profile_screen.dart';
import 'package:errunds_application/screens/customer/seeting_screen.dart';
import 'package:errunds_application/screens/customer/transaction_screen.dart.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomerWelcomeScreen extends StatefulWidget {
  const CustomerWelcomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _CustomerWelcomeScreenState createState() => _CustomerWelcomeScreenState();
}

class _CustomerWelcomeScreenState extends State<CustomerWelcomeScreen> {
  int currentIndex = 0;

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      label: "",
      icon: Icon(
        MdiIcons.home,
        color: primaryColor,
      ),
    ),
    BottomNavigationBarItem(
      label: "",
      icon: Icon(
        MdiIcons.account,
        color: primaryColor,
      ),
    ),
    BottomNavigationBarItem(
      label: "",
      icon: Icon(MdiIcons.swapHorizontalBold, color: primaryColor),
    ),
    BottomNavigationBarItem(
      label: "",
      icon: Icon(MdiIcons.menu, color: primaryColor),
    ),
  ];

  setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: secondaryColor),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          iconSize: 35,
          onTap: (index) {
            setIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          items: items,
          backgroundColor: secondaryColor,
        ),
      ),
      body: SafeArea(
        child: PageView(
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: [
            if (currentIndex == 0) CustomerHomeScren(),
            if (currentIndex == 1) ProfileScreen(),
            if (currentIndex == 2) Transactionscreen(),
            if (currentIndex == 3) SettingScreen(),
          ],
        ),
      ),
    );
  }
}
