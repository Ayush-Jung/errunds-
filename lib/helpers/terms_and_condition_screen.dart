import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/service_terms.dart';
import 'package:errunds_application/helpers/terms_for_signup.dart';
import 'package:flutter/material.dart';

class TermsAndConditionScreen extends StatelessWidget {
  TermsAndConditionScreen(
      {Key key,
      this.parcel = false,
      this.signup = false,
      this.delivery = false,
      this.food_delivery = false,
      this.grocery = false,
      this.postal = false,
      this.utility = false})
      : super(key: key);
  final bool parcel;
  final bool postal;
  final bool delivery;
  final bool grocery;
  final bool food_delivery;
  final bool utility;

  final bool signup;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          backgroundColor: secondaryColor,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: primaryColor,
          ),
          title: Text(
            chooseName(),
            style: TextStyle(color: primaryColor),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (signup)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      terms,
                      style: style,
                    ),
                  ),
                if (postal)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(postal_terms, style: style),
                  ),
                if (food_delivery)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(food_delivery_terms, style: style),
                  ),
                if (grocery)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(grocery_terms, style: style),
                  ),
                if (utility)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(utility_terms, style: style),
                  ),
                if (delivery)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(delivery_terms, style: style),
                  ),
                if (parcel)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      parcel_terms,
                      style: style,
                    ),
                  ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("I agree the terms and conditions",
                        style: TextStyle(color: secondaryColor)))
              ],
            ),
          ),
        ),
      );

  String chooseName() {
    if (utility) {
      return "Utility Terms";
    } else if (postal) {
      return "Postal Terms";
    } else if (delivery) {
      return "Laundry Delivery Terms";
    } else if (food_delivery) {
      return "Food Delivery Terms";
    } else if (grocery) {
      return "Grocery Terms";
    } else if (parcel) {
      return "Parcel Delivery Terms";
    } else {
      return "Terms and Conditions";
    }
  }

  TextStyle get style => TextStyle(color: primaryColor);
}
