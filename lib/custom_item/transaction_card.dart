import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/custom_text_field.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:errunds_application/screens/driver/service_detail.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatefulWidget {
  final Service completedService;
  const TransactionCard({
    Key key,
    this.completedService,
  }) : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  ErrundUser currentUser, riderInfo;
  @override
  void initState() {
    getRiderInfo();
    super.initState();
  }

  getRiderInfo() async {
    riderInfo = await firebase.getUserById(widget.completedService.riderId);
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
                      service: widget.completedService,
                      riderInfo: riderInfo,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: buttonBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getKeyValue(
              context,
              "Service Name",
              value: widget.completedService?.serviceName ?? "",
              valueColor: Colors.white,
            ),
            getKeyValue(
              context,
              "Rider Name",
              value: riderInfo?.fName ?? "",
              valueColor: Colors.white,
            ),
            getKeyValue(
              context,
              "Service Status",
              value:
                  getKeyFromServiceStatusType(widget.completedService.status) ??
                      "",
              valueColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
