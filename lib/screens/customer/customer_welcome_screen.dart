import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/navigation_provider.dart';
import 'package:errunds_application/screens/customer/customer_home_screen.dart';
import 'package:errunds_application/screens/customer/customer_profile.dart';
import 'package:errunds_application/screens/customer/customer_setting.dart';
import 'package:errunds_application/screens/customer/customer_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CustomerWelcomeScreen extends StatefulWidget {
  const CustomerWelcomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _CustomerWelcomeScreenState createState() => _CustomerWelcomeScreenState();
}

class _CustomerWelcomeScreenState extends State<CustomerWelcomeScreen> {
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
            color: buttonBackgroundColor),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          iconSize: 35,
          onTap: (index) {
            navigationProvider.setIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          items: items,
          backgroundColor: buttonBackgroundColor,
        ),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: [
            CustomerHomeScren(active: currentIndex == 0),
            CustomerProfileScreen(active: currentIndex == 1),
            CustomerTransactionScreen(active: currentIndex == 2),
            CustomerSettingScreen(active: currentIndex == 3),
          ],
        ),
      ),
    );
  }
}
