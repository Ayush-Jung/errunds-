import 'package:errunds_application/custom_item/horizontal_menu.dart';
import 'package:errunds_application/custom_item/transaction_card.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:flutter/material.dart';

class Transactionscreen extends StatefulWidget {
  const Transactionscreen({Key key, this.active, this.isRider = false})
      : super(key: key);
  final bool active, isRider;

  @override
  _TransactionscreenState createState() => _TransactionscreenState();
}

class _TransactionscreenState extends State<Transactionscreen> {
  List<Service> completedServices, startedServices;
  String filter = "Active-service";
  List<String> menu = ["Active-service", "Completed-service"];

  @override
  void initState() {
    firebase
        .getCompletedServices(isRider: widget.isRider)
        .then((List<Service> services) {
      setState(() {
        completedServices = services;
      });
    });
    getStartedServices();
    super.initState();
  }

  getStartedServices() async {
    startedServices = await firebase.getActiveServices(isRider: widget.isRider);
    setState(() {});
  }

  getStartedService() {
    return Column(
      children: [
        if (startedServices == null)
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else if (startedServices.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                "No Services Found",
                style: Theme.of(context)
                    .primaryTextTheme
                    .caption
                    .copyWith(color: primaryColor),
              ),
            ),
          )
        else
          Expanded(
            child: ListView(
              children: startedServices.map((service) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TransactionCard(
                    isRider: widget.isRider,
                    completedService: service,
                  ),
                );
              }).toList(),
            ),
          )
      ],
    );
  }

  getCompletedServices() {
    return Column(
      children: [
        if (completedServices == null)
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        else if (completedServices.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                "No Services Found",
                style: Theme.of(context)
                    .primaryTextTheme
                    .caption
                    .copyWith(color: primaryColor),
              ),
            ),
          )
        else
          Expanded(
            child: ListView(
              children: completedServices.map((service) {
                return TransactionCard(
                  isRider: widget.isRider,
                  completedService: service,
                );
              }).toList(),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Center(
            child: Text(
          "Services",
          style: TextStyle(color: primaryColor),
        )),
        backgroundColor: secondaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
              child: HorizontalMenuLab(menu, filter, (value) {
                setState(() {
                  filter = value;
                });
              }),
            ),
            const SizedBox(height: 16.0),
            if (filter == "Active-service")
              Expanded(child: getStartedService())
            else
              Expanded(child: getCompletedServices())
          ],
        ),
      ),
    );
  }
}
