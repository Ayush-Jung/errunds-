import 'package:errunds_application/custom_item/horizontal_menu.dart';
import 'package:errunds_application/custom_item/transaction_card.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:flutter/material.dart';

class Transactionscreen extends StatefulWidget {
  const Transactionscreen(
      {Key key, this.active, this.isRider = false, this.filter})
      : super(key: key);
  final bool active, isRider;
  final String filter;

  @override
  _TransactionscreenState createState() => _TransactionscreenState();
}

class _TransactionscreenState extends State<Transactionscreen> {
  List<Service> completedServices, startedServices;
  List<Service> cutomerActiveStartedServices = [], riderStartedService = [];

  String filter = "Active-service";
  List<String> menu = ["Active-service", "Completed-service"];

  @override
  void initState() {
    if (widget.filter != null) {
      filter = widget.filter;
      setState(() {});
    }
    firebase
        .getCompletedServices(isRider: widget.isRider)
        .then((List<Service> services) {
      setState(() {
        completedServices = services;
      });
    });
    firebase
        .getActiveServices(isRider: widget.isRider)
        .then((List<Service> services) {
      if (services.length == 0) {
        startedServices = [];
      } else {
        services.forEach((service) {
          if (widget.isRider && service.status == ServiceStatus.STARTED) {
            setState(() {
              riderStartedService.add(service);
              startedServices = riderStartedService;
            });
          } else if (!widget.isRider &&
              (service.status == ServiceStatus.ACTIVE ||
                  service.status == ServiceStatus.STARTED)) {
            setState(() {
              cutomerActiveStartedServices.add(service);
              startedServices = cutomerActiveStartedServices;
            });
          } else {
            setState(() {
              startedServices = [];
            });
          }
        });
      }
    });
    super.initState();
  }

  getStartedService() {
    return Column(
      children: [
        if (startedServices == null)
          Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
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
          Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
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
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
        centerTitle: true,
        title: Text(
          "Services",
          style: TextStyle(color: primaryColor),
        ),
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
