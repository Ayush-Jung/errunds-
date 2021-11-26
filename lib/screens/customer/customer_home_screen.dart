import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/home_item.dart';
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
  String customerId;
  HomeItem homeItem;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  // List<HomeItem> homeItems = [
  //   HomeItem(
  //     title: "Grocery",
  //     icondata: MdiIcons.cart,
  //   ),
  //   HomeItem(
  //       title: "Parcel Delivery", icondata: MdiIcons.coatRack, callback: () {}),
  //   HomeItem(
  //     title: "Food Delivery",
  //     icondata: MdiIcons.foodVariant,
  //     callback: () => const ServiceScreen(
  //       title: "Food Delivery",
  //     ),
  //   ),
  //   HomeItem(
  //     title: "Laundry Pick-Up",
  //     icondata: MdiIcons.tshirtCrew,
  //     callback: () =>
  //         Navigator.pushNamed(HomeItem().context, "/service_screen"),
  //   ),
  //   HomeItem(
  //     title: "Postal Service",
  //     icondata: MdiIcons.mailboxOpen,
  //     callback: () => const ServiceScreen(
  //       title: "Postal Service",
  //     ),
  //   ),
  //   HomeItem(
  //     title: "Pay Bills",
  //     icondata: MdiIcons.cashMultiple,
  //   ),
  // ];
  @override
  void initState() {
    customerId = firebase.currentUser;
    super.initState();
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
                        text: "customer.fname,",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ServiceScreen(
                            title: "Grocery Service",
                          ),
                        ),
                      );
                    },
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.width * 0.45,
                          minWidth: MediaQuery.of(context).size.width * 0.45),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDFAE4),
                        borderRadius: BorderRadius.all(
                          Radius.circular(22),
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.cart,
                              size: 70,
                              color: buttonBackgroundColor,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Grocery",
                              style: TextStyle(
                                  color: Color(0XFFEF2F2C),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.width * 0.45,
                          minWidth: MediaQuery.of(context).size.width * 0.45),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDFAE4),
                        borderRadius: BorderRadius.all(
                          Radius.circular(22),
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.cart,
                              size: 70,
                              color: buttonBackgroundColor,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Parcel Delivery",
                              style: TextStyle(
                                  color: Color(0XFFEF2F2C),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.width * 0.45,
                          minWidth: MediaQuery.of(context).size.width * 0.45),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDFAE4),
                        borderRadius: BorderRadius.all(
                          Radius.circular(22),
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.backburger,
                              size: 70,
                              color: buttonBackgroundColor,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Food delivery",
                              style: TextStyle(
                                  color: Color(0XFFEF2F2C),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.width * 0.45,
                          minWidth: MediaQuery.of(context).size.width * 0.45),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDFAE4),
                        borderRadius: BorderRadius.all(
                          Radius.circular(22),
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.cart,
                              size: 70,
                              color: buttonBackgroundColor,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Laundry Pick-Up",
                              style: TextStyle(
                                  color: Color(0XFFEF2F2C),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.width * 0.45,
                          minWidth: MediaQuery.of(context).size.width * 0.45),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDFAE4),
                        borderRadius: BorderRadius.all(
                          Radius.circular(22),
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.mail,
                              size: 70,
                              color: buttonBackgroundColor,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Postal service",
                              style: TextStyle(
                                  color: Color(0XFFEF2F2C),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.width * 0.45,
                          minWidth: MediaQuery.of(context).size.width * 0.45),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFDFAE4),
                        borderRadius: BorderRadius.all(
                          Radius.circular(22),
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.cashMultiple,
                              size: 70,
                              color: buttonBackgroundColor,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Pay Bills",
                              style: TextStyle(
                                  color: Color(0XFFEF2F2C),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
