import 'package:errunds_application/custom_item/custom_container.dart';
import 'package:errunds_application/helpers/custom_text_field.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Detail"),
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
                  getKeyValue(context, "Customer contact",
                      value: widget.service?.contact_num ?? "-"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
