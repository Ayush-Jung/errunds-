import 'dart:async';

import 'package:errunds_application/helpers/calculate_price_provider.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/home_item.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
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

  List<HomeItem> homeItems(BuildContext context) => [
        HomeItem(
          title: "Grocery",
          icondata: MdiIcons.cart,
          callback: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ServiceScreen(
                  title: "Grocery",
                  isGroceryService: true,
                ),
              ),
            );
          },
        ),
        HomeItem(
          title: "Parcel Delivery",
          icondata: MdiIcons.coatRack,
          callback: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ServiceScreen(
                  title: "Parcel Delivery",
                  isParcelService: true,
                ),
              ),
            );
          },
        ),
        HomeItem(
          title: "Food Delivery",
          icondata: MdiIcons.foodVariant,
          callback: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ServiceScreen(
                  title: "Food Delivery",
                  isFoodDelivery: true,
                ),
              ),
            );
          },
        ),
        HomeItem(
          title: "Laundry Pick-Up",
          icondata: MdiIcons.tshirtCrew,
          callback: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ServiceScreen(
                  title: "Laundry Pick-Up",
                  isLaundryservice: true,
                ),
              ),
            );
          },
        ),
        HomeItem(
          title: "Postal Service",
          icondata: MdiIcons.mailboxOpen,
          callback: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ServiceScreen(
                  title: "Postal Delivery",
                  isPostalService: true,
                ),
              ),
            );
          },
        ),
        HomeItem(
          title: "Pay Bills",
          icondata: MdiIcons.cashMultiple,
          callback: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ServiceScreen(
                  title: "Pay Bills",
                  ispayBillService: true,
                ),
              ),
            );
          },
        ),
      ];

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    errundUser = await firebase.getUserInfo();
    setState(() {});
  }

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
            if (errundUser == null)
              SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(
                    color: secondaryColor,
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
                        color: secondaryColor),
                    children: [
                      TextSpan(
                        text: errundUser?.fName,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              children: homeItems(context)
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HomeCard(
                        title: e.title,
                        icon: e.icondata,
                        callback: e.callback,
                      ),
                    ),
                  )
                  .toList(),
            )
          ]),
        ),
      ),
    );
  }
}
