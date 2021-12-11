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
  @override
  void dispose() {
    navigationProvider.dispose();
    super.dispose();
  }

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
            RiderHomePage(),
            ProfileScreen(),
            Transactionscreen(
              isRider: true,
            ),
            SettingScreen(),
          ],
        ),
      ),
    );
  }
}
