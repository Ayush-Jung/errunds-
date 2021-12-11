import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:errunds_application/screens/customer/customer_welcome_screen.dart';
import 'package:errunds_application/screens/customer/rider_detail.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ScanOnlineRider extends StatefulWidget {
  final String serviceId;
  const ScanOnlineRider({
    this.serviceId,
    Key key,
  }) : super(key: key);

  @override
  _ScanOnlineRiderState createState() => _ScanOnlineRiderState();
}

class _ScanOnlineRiderState extends State<ScanOnlineRider> {
  ErrundUser onlineRider;
  Service service;
  bool isSearching = false;
  bool riderNotFound = false;

  @override
  void initState() {
    searchRider();
    super.initState();
  }

  searchRider() {
    getLoading(true);
    setState(() {
      riderNotFound = false;
    });
    Timer(const Duration(seconds: 40), () {
      if (onlineRider == null) {
        if (mounted) {
          setState(() {
            riderNotFound = true;
          });
        }
      }
      getLoading(false);
    });
    firebase.getServiceById(widget.serviceId, (Service service) {
      this.service = service;
      if (service.riderId != null) {
        getRider(service.riderId);
      }
      setState(() {});
    });
  }

  getRider(String riderId) async {
    await firebase.getUserById(userId: service.riderId).then((user) {
      setState(() {
        onlineRider = user;
        isSearching = false;
      });
    });
  }

  getLoading(value) {
    setState(() {
      isSearching = value;
    });
  }

  cancelService() async {
    await firebase.abortService(service.id, status: ServiceStatus.ABORTED);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const CustomerWelcomeScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: primaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (riderNotFound) ...[
              const SizedBox(height: 10),
              Text(
                "Rider Not Found",
                style: TextStyle(color: secondaryColor),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(secondaryColor)),
                child: Text(
                  "Retry",
                  style: TextStyle(color: primaryColor),
                ),
                onPressed: () => searchRider(),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(secondaryColor)),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: primaryColor),
                ),
                onPressed: () => cancelService(),
              )
            ],
            if (isSearching) ...[
              AvatarGlow(
                endRadius: 130.0,
                glowColor: secondaryColor,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(milliseconds: 100),
                child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: secondaryColor.withOpacity(0.4),
                    child: CircleAvatar(
                      backgroundColor: secondaryColor,
                      radius: 5,
                    ),
                    radius: 10.0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Searching for Online Riders...",
                style: TextStyle(color: secondaryColor),
              ),
            ] else if (!isSearching && onlineRider != null) ...[
              const SizedBox(height: 5),
              Text(
                "Rider Found",
                style: TextStyle(color: secondaryColor),
              ),
              const SizedBox(height: 5),
              StyledRiderCard(
                riderName: onlineRider.fName,
              ),
              StyledRiderCard(
                riderName: onlineRider.phoneNumber,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text("Continue"),
                onPressed: () {
                  Navigator.pop(context, true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RiderDetailScreen(
                        rider: onlineRider,
                        service: service,
                      ),
                    ),
                  );
                },
              ),
            ]
          ],
        ),
      ],
    );
  }
}

class StyledRiderCard extends StatelessWidget {
  final String riderName;
  const StyledRiderCard({
    Key key,
    this.riderName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xffF1FDE5),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xff0000001A),
            spreadRadius: 0.4,
            blurRadius: 0.4,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              riderName ?? "",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Icon(
            MdiIcons.checkCircleOutline,
            color: secondaryColor,
            size: 30,
          ),
        ],
      ),
    );
  }
}
