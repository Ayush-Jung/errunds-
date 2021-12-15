import 'package:errunds_application/custom_item/custom_container.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/custom_text_field.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:errunds_application/screens/driver/service_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  final Service completedService;
  final bool isRider;
  const TransactionCard({
    Key key,
    this.completedService,
    this.isRider = false,
  }) : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  ErrundUser currentUser, userInfo;
  DateFormat formatter = DateFormat("hh:mm a, dd MMM");

  @override
  void initState() {
    getRiderInfo();
    super.initState();
  }

  getRiderInfo() async {
    userInfo = await firebase.getUserById(
        userId: widget.isRider
            ? widget.completedService.riderId
            : widget.completedService.customerId);
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
              isRider: widget.isRider,
              service: widget.completedService,
              riderInfo: userInfo,
            ),
          ),
        );
      },
      child: CustomContainer(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getKeyValue(
              context,
              "Service Name",
              value: widget.completedService?.serviceName ?? "",
              valueColor: secondaryColor,
            ),
            if (widget.completedService.createdDate != null)
              getKeyValue(
                context,
                "Created Date",
                value: formatter.format(DateTime.fromMillisecondsSinceEpoch(
                    widget.completedService.createdDate)),
                valueColor: secondaryColor,
              ),
            if (!widget.isRider &&
                widget.completedService.status != ServiceStatus.ACTIVE) ...[
              getKeyValue(
                context,
                "Rider Name",
                value: userInfo?.fName ?? "",
                valueColor: secondaryColor,
              ),
            ],
            getKeyValue(
              context,
              "Service Status",
              value:
                  getKeyFromServiceStatusType(widget.completedService.status) ??
                      "",
              valueColor: secondaryColor,
            )
          ],
        ),
      ),
    );
  }
}
