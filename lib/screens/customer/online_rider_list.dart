import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:flutter/material.dart';

class OnlineRiders extends StatefulWidget {
  const OnlineRiders({Key key}) : super(key: key);

  @override
  _OnlineRidersState createState() => _OnlineRidersState();
}

class _OnlineRidersState extends State<OnlineRiders> {
  List<ErrundUser> onlineRiders;
  @override
  void initState() {
    getOnlineRiders();
    super.initState();
  }

  getOnlineRiders() async {
    onlineRiders = await firebase.getOnlineRiders();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Riders"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: onlineRiders
                .map((e) => OnlineriderCard(
                      onlineRiders: e,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class OnlineriderCard extends StatelessWidget {
  final ErrundUser onlineRiders;
  const OnlineriderCard({Key key, this.onlineRiders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            color: primaryColor),
        child: ListTile(
          title: Text(onlineRiders.fName ?? ""),
          subtitle: Text(onlineRiders.companyId),
        ));
  }
}
