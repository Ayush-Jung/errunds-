import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
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

  @override
  void initState() {
    searchRider();
    super.initState();
  }

  searchRider() {
    isSearching = true;
    Timer(const Duration(seconds: 10), () {
      print("called 1");
      isSearching = false;
      setState(() {
        isSearching = null;
      });
    });
    firebase.getServiceById(widget.serviceId, (Service service) async {
      print("called 2");

      this.service = service;
      if (service.riderId != null) {
        onlineRider = await firebase.getUserById(service.riderId);
        setState(() {});
      }
      setState(() {});
      print("called 3");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      children: <Widget>[
        Column(
          children: <Widget>[
            if (isSearching == null) ...[
              const SizedBox(height: 10),
              const Text("Rider Not Found"),
              const SizedBox(height: 20),
              CustomButton(
                label: "Retry",
                onPress: () => searchRider,
              ),
            ] else if (isSearching) ...[
              AvatarGlow(
                endRadius: 130.0,
                glowColor: Colors.blue,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(milliseconds: 100),
                child: Material(
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 5,
                    ),
                    radius: 10.0,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Text("Scanning for Online Riders..."),
            ] else if (onlineRider != null) ...[
              const SizedBox(height: 10),
              const Icon(
                MdiIcons.checkCircleOutline,
                color: Colors.green,
              ),
              const SizedBox(height: 10),
              const Text("Rider Found"),
              const SizedBox(height: 10),
              StyledRiderCard(
                riderName: onlineRider.fName,
              ),
              StyledRiderCard(
                riderName: onlineRider.phoneNumber,
              ),
              const SizedBox(height: 10),
              CustomButton(
                  label: "Continue",
                  onPress: () {
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
                  }),
            ]
          ],
        ),
      ],
    );
  }
}

class StyledRiderCard extends StatelessWidget {
  final String riderName;
  final bool showMoreInfo;
  const StyledRiderCard({Key key, this.riderName, this.showMoreInfo = false})
      : super(key: key);

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  riderName ?? "",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                showMoreInfo
                    ? const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Rider Found",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
          const SizedBox(width: 5),
          const Icon(
            MdiIcons.checkCircleOutline,
            color: Colors.green,
            size: 30,
          ),
        ],
      ),
    );
  }
}
