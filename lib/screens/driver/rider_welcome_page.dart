import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/navigation_provider.dart';
import 'package:errunds_application/screens/customer/profile_screen.dart';
import 'package:errunds_application/screens/customer/seeting_screen.dart';
import 'package:errunds_application/screens/customer/transaction_screen.dart.dart';
import 'package:errunds_application/screens/driver/rider_home_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class RiderWelcomeScreen extends StatefulWidget {
  const RiderWelcomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _RiderWelcomeScreenState createState() => _RiderWelcomeScreenState();
}

class _RiderWelcomeScreenState extends State<RiderWelcomeScreen> {
  int currentIndex = 0;
  NavigationProvider navigationProvider;

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      label: "",
      icon: Icon(
        MdiIcons.home,
        color: Colors.white,
      ),
    ),
    const BottomNavigationBarItem(
      label: "",
      icon: Icon(
        MdiIcons.account,
        color: Colors.white,
      ),
    ),
    const BottomNavigationBarItem(
      label: "",
      icon: Icon(MdiIcons.swapHorizontalBold, color: Colors.white),
    ),
    const BottomNavigationBarItem(
      label: "",
      icon: Icon(MdiIcons.menu, color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    navigationProvider = Provider.of<NavigationProvider>(context);
    currentIndex = navigationProvider.currentIndex;
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: secondaryColor),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          iconSize: 35,
          onTap: (index) {
            navigationProvider.setIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          items: items,
          backgroundColor: secondaryColor,
        ),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: [
            RiderHomePage(active: currentIndex == 0),
            ProfileScreen(active: currentIndex == 1),
            Transactionscreen(
              active: currentIndex == 2,
              isRider: true,
            ),
            SettingScreen(active: currentIndex == 3),
          ],
        ),
      ),
    );
  }
}
