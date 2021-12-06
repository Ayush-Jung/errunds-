import 'package:errunds_application/custom_item/horizontal_menu.dart';
import 'package:errunds_application/custom_item/transaction_card.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:flutter/material.dart';

class CustomerTransactionScreen extends StatefulWidget {
  const CustomerTransactionScreen({Key key, this.active}) : super(key: key);
  final bool active;

  @override
  _CustomerTransactionScreenState createState() =>
      _CustomerTransactionScreenState();
}

class _CustomerTransactionScreenState extends State<CustomerTransactionScreen> {
  List<Service> completedServices, startedServices;
  String filter = "Active-service";
  List<String> menu = ["Active-service", "Completed-service"];

  @override
  void initState() {
    firebase.getCompletedServices().then((List<Service> services) {
      setState(() {
        completedServices = services;
      });
    });
    getStartedServices();
    super.initState();
  }

  getStartedServices() async {
    startedServices = await firebase.getActiveServices();
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
                    .copyWith(color: buttonBackgroundColor),
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
                    .copyWith(color: buttonBackgroundColor),
              ),
            ),
          )
        else
          Expanded(
            child: ListView(
              children: completedServices.map((service) {
                return TransactionCard(
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
      appBar: AppBar(
        title: const Text("Services"),
        backgroundColor: buttonBackgroundColor,
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
