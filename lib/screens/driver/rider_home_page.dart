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
                    "Hi, ${currentRider?.fName ?? ""}",
                    style: TextStyle(
                        color: buttonBackgroundColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: MediaQuery.of(context).size.width * 0.19),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
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
                      fontSize: 25),
                ),
              ),
              if (activeServices == null || activeServices.isEmpty)
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      "No active task found.",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
    getCustomerInfo();
    super.initState();
  }

  getCustomerInfo() async {
    customerInfo = await firebase.getUserById(widget.serviceInfo?.customerId);
    setState(() {
      widget.serviceInfo.status == ServiceStatus.ACTIVE ? active = true : false;
    });
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
                ? Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Colors.black,
                    ),
                    padding: const EdgeInsets.all(8),
                    height: 90,
                    width: 90,
                    child: const CircleAvatar(
                      radius: 80,
                      child: Text(
                        "Add image",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(customerInfo?.imageUrl)),
                    ),
                  ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customerInfo?.fName ?? ""),
                  Text(widget.serviceInfo?.serviceName ?? ""),
                  Text(widget.serviceInfo?.route ?? ""),
                ],
              ),
            ),
            Visibility(
              visible: active,
              child: MaterialButton(
                onPressed: () => activateService(),
                child: const Text(
                  "Accept",
                  style: TextStyle(color: Colors.white),
                ),
                color: buttonBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
