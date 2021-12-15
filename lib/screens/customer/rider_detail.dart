import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/custom_item/custom_container.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/custom_text_field.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:errunds_application/screens/customer/customer_welcome_screen.dart';
import 'package:flutter/material.dart';

class RiderDetailScreen extends StatefulWidget {
  const RiderDetailScreen({Key key, this.rider, this.service})
      : super(key: key);
  final ErrundUser rider;
  final Service service;
  @override
  _RiderDetailScreenState createState() => _RiderDetailScreenState();
}

class _RiderDetailScreenState extends State<RiderDetailScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: secondaryColor,
        elevation: 1.2,
        centerTitle: true,
        title: Text(
          "Service Detail",
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomContainer(
              child: Column(
                children: [
                  getKeyValue(context, "service Name",
                      value: widget.service?.serviceName),
                  getKeyValue(context, "Rider contact",
                      value: widget.rider?.phoneNumber),
                  getKeyValue(context, "Payment status",
                      value: getKeyFromPaymentStatus(
                          widget.service?.paymentStatus)),
                  getKeyValue(context, "Service status",
                      value:
                          getKeyFromServiceStatusType(widget.service?.status)),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                          "You can cancel before 30 min of service time.",
                          style: TextStyle(color: secondaryColor))),
                  CustomButton(
                      label: "Confirm",
                      loading: loading,
                      textColor: primaryColor,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CustomerWelcomeScreen(),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
