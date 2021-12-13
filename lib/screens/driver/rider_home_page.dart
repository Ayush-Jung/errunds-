import 'dart:async';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:errunds_application/screens/driver/service_detail.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RiderHomePage extends StatefulWidget {
  const RiderHomePage({
    Key key,
  }) : super(key: key);

  @override
  _RiderHomePageState createState() => _RiderHomePageState();
}

class _RiderHomePageState extends State<RiderHomePage> {
  ErrundUser currentRider;
  List<Service> activeServices;
  StreamSubscription activeServicesSub;
  @override
  void initState() {
    activeServicesSub =
        firebase.getRealTimeServices((List<Service> allActiveServices) {
      if (mounted) {
        setState(() {
          activeServices = allActiveServices;
        });
      }
    });
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    currentRider = await firebase.getUserInfo();
    setState(() {});
  }

  @override
  void dispose() {
    activeServicesSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                  child: errunds),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Text(
                  "Hi, ${currentRider?.fName ?? ""}",
                  style: TextStyle(
                      color: secondaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: MediaQuery.of(context).size.width * 0.19),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Text(
                  "Available Task",
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              if (activeServices == null || activeServices.isEmpty)
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "No active task found.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: secondaryColor),
                    ),
                  ),
                ),
              if (activeServices != null) ...[
                Column(
                    children: activeServices
                        ?.map((service) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TaskCard(
                                serviceInfo: service,
                              ),
                            ))
                        ?.toList()),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatefulWidget {
  final Service serviceInfo;
  const TaskCard({Key key, this.serviceInfo}) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  ErrundUser customerInfo;

  bool active = false;
  activateService() async {
    if (active) {
      await firebase.lockTheService(widget.serviceInfo.id);
    }
    setState(() {
      active = false;
    });
  }

  @override
  void initState() {
    widget.serviceInfo.status == ServiceStatus.ACTIVE ? active = true : false;
    setState(() {});
    getCustomerInfo();
    super.initState();
  }

  getCustomerInfo() async {
    customerInfo =
        await firebase.getUserById(userId: widget.serviceInfo?.customerId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceDetailScreen(
              service: widget.serviceInfo,
              customer: customerInfo,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color(0xfffdf9d9),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customerInfo?.imageUrl == null
                ? CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 40,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        MdiIcons.faceMan,
                        color: secondaryColor,
                        size: 30,
                      ),
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 40,
                    backgroundImage: NetworkImage(customerInfo?.imageUrl),
                  ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Client Name: ${customerInfo?.fName ?? ""}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Task: ${widget.serviceInfo?.serviceName ?? ""}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("Route: ${widget.serviceInfo?.route?.keys?.first ?? ""}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              child: MaterialButton(
                minWidth: 25,
                onPressed: () {
                  active ? activateService() : null;
                },
                child: Text(
                  active ? "Accept" : "Accepted",
                  style: const TextStyle(color: Colors.white),
                ),
                color: secondaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
