import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/home_item.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/screens/auth/choose_auth.dart';
import 'package:errunds_application/screens/customer/home_card.dart';
import 'package:errunds_application/screens/customer/service_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter/material.dart';

class CustomerHomeScren extends StatefulWidget {
  const CustomerHomeScren({Key key, this.active}) : super(key: key);
  final bool active;

  @override
  _CustomerHomeScrenState createState() => _CustomerHomeScrenState();
}

class _CustomerHomeScrenState extends State<CustomerHomeScren> {
  ErrundUser errundUser;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  List<HomeItem> homeItems = [
    HomeItem(
      title: "Grocery",
      icondata: MdiIcons.cart,
    ),
    HomeItem(
        title: "Parcel Delivery", icondata: MdiIcons.coatRack, callback: () {}),
    HomeItem(
      title: "Food Delivery",
      icondata: MdiIcons.foodVariant,
      callback: () => const ServiceScreen(
        title: "Food Delivery",
      ),
    ),
    HomeItem(
      title: "Laundry Pick-Up",
      icondata: MdiIcons.tshirtCrew,
      // callback: () =>
      //     Navigator.pushNamed(context, "/service_screen"),
    ),
    HomeItem(
      title: "Postal Service",
      icondata: MdiIcons.mailboxOpen,
      callback: () => const ServiceScreen(
        title: "Postal Service",
      ),
    ),
    HomeItem(
      title: "Pay Bills",
      icondata: MdiIcons.cashMultiple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: const Color(0xFFF5E87D),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: CustomScrollView(slivers: [
            if (firebase.errundUser == null)
              SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(
                    color: buttonBackgroundColor,
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(alignment: Alignment.center, child: errunds),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                child: RichText(
                  text: TextSpan(
                    text: "HI,  ",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: buttonBackgroundColor),
                    children: [
                      TextSpan(
                        text: firebase.errundUser?.fName,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () => firebase.logOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const AuthChooser()));
                }),
                child: Text("Log-Out"),
              ),
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HomeCard(
                        title: homeItems[index].title,
                        icon: homeItems[index].icondata,
                        callback: () {
                          homeItems[index].callback;
                        },
                      ),
                    );
                  },
                  childCount: homeItems.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2))
          ]),
        ),
      ),
    );
  }
}
