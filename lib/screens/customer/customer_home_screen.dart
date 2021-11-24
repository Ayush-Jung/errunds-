import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/customer.dart';
import 'package:errunds_application/models/customer_Models/home_item.dart';
import 'package:errunds_application/screens/customer/home_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter/material.dart';

class CustomerHomeScren extends StatefulWidget {
  const CustomerHomeScren({Key key, this.active}) : super(key: key);
  final bool active;

  @override
  _CustomerHomeScrenState createState() => _CustomerHomeScrenState();
}

class _CustomerHomeScrenState extends State<CustomerHomeScren> {
  Customer customer;
  String customerId;
  List<HomeItem> homeItems = [
    HomeItem(
      title: "Grocery",
      icondata: MdiIcons.cart,
    ),
    HomeItem(
      title: "Parcel Delivery",
      icondata: MdiIcons.coatRack,
    ),
    HomeItem(
      title: "Food Delivery",
      icondata: MdiIcons.foodVariant,
    ),
    HomeItem(
      title: "Laundry Pick-Up",
      icondata: MdiIcons.tshirtCrew,
    ),
    HomeItem(
      title: "Postal",
      icondata: MdiIcons.mailboxOpen,
    ),
    HomeItem(
      title: "Pay Bills",
      icondata: MdiIcons.cashMultiple,
    ),
  ];
  @override
  void initState() {
    customerId = firebase.currentUser;
    getCustomer();
    super.initState();
  }

  getCustomer() async {
    customer = await firebase.getCustomerInfo(customerId: customerId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E87D),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            if (customer == null)
              SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(
                    color: buttonBackgroundColor,
                  ),
                ),
              )
            else ...[
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
                          text: customer.fname,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.80, crossAxisCount: 2),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HomeCard(
                      title: homeItems[index]?.title,
                      icon: homeItems[index]?.icondata,
                    ),
                  );
                }, childCount: homeItems.length),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
