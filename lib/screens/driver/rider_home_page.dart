import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:errunds_application/screens/driver/service_detail.dart';
import 'package:flutter/material.dart';

class RiderHomePage extends StatefulWidget {
  final bool active;

  const RiderHomePage({Key key, this.active}) : super(key: key);

  @override
  _RiderHomePageState createState() => _RiderHomePageState();
}

class _RiderHomePageState extends State<RiderHomePage> {
  ErrundUser currentRider;
  List<Service> activeServices;
  @override
  void initState() {
    firebase.getRealTimeServices((List<Service> allActiveServices) {
      setState(() {
        activeServices = allActiveServices;
      });
    });
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    currentRider = await firebase.getUserInfo();
    setState(() {});
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
                child: InkWell(
                  onTap: () {
                    firebase.logOut();
                  },
                  child: Text(
                    "Hi, ${currentRider.fName}",
                    style: TextStyle(
                        color: buttonBackgroundColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: MediaQuery.of(context).size.width * 0.19),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: buttonBackgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: const Text(
                  "Available Task",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              if (activeServices == null)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (activeServices.isEmpty)
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text("No active task found"),
                )
              else
                Column(
                    children: activeServices
                        .map((service) => TaskCard(
                              serviceInfo: service,
                            ))
                        .toList()),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatefulWidget {
  final ErrundUser customerInfo;
  final Service serviceInfo;
  const TaskCard({Key key, this.customerInfo, this.serviceInfo})
      : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool changebutton = false;
  activateService() async {
    changebutton = await firebase.lockTheService(widget.serviceInfo.id);
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
              customer: widget.customerInfo,
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
            widget.customerInfo.imageUrl != null
                ? Container(
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.customerInfo.imageUrl)),
                    ),
                  )
                : Container(
                    color: Colors.black,
                    padding: const EdgeInsets.all(8),
                    height: 100,
                    width: 120,
                    child: const CircleAvatar(
                      radius: 80,
                      child: Text(
                        "add image",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(widget.customerInfo.fName),
                Text(widget.serviceInfo.serviceName),
                Text(widget.serviceInfo.route),
              ],
            ),
            Expanded(
              child: CustomButton(
                label: changebutton ? "Accepted" : "Accept Task",
                onPress: () {
                  activateService();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
