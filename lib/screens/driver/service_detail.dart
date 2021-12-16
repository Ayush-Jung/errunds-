import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/custom_item/custom_container.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/custom_text_field.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:errunds_application/screens/customer/customer_welcome_screen.dart';
import 'package:errunds_application/screens/driver/rider_welcome_page.dart';
import 'package:errunds_application/screens/rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceDetailScreen extends StatefulWidget {
  final Service service;
  final ErrundUser customer;
  final ErrundUser riderInfo;
  final bool isRider;
  const ServiceDetailScreen(
      {Key key,
      this.service,
      this.riderInfo,
      this.customer,
      this.isRider = false})
      : super(key: key);

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  Service currentService;
  ErrundUser customerInfo;
  bool loading = false;
  DateFormat formatter = DateFormat("hh:mm a, dd MMM");

  @override
  void initState() {
    setState(() {
      currentService = widget.service;
      print(currentService.serviceName);
      customerInfo = widget.customer;
    });

    super.initState();
  }

  showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          title:
              Text("Finish Service?", style: TextStyle(color: secondaryColor)),
          content: Text(
              "payment is not completed. Do you want to complete with cash?",
              style: TextStyle(color: secondaryColor)),
          actions: <Widget>[
            TextButton(
              child: Text("Yes", style: TextStyle(color: secondaryColor)),
              onPressed: () async {
                await firebase.unLockTheService(currentService.id);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RiderWelcomeScreen(
                        afterComplete: true,
                      ),
                    ),
                    (route) => false);
              },
            ),
            TextButton(
              child: Text("No", style: TextStyle(color: secondaryColor)),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  _showSnackbar(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: primaryColor,
      content: Text(message, style: TextStyle(color: secondaryColor)),
    ));
  }

  showCancelDialog(
    BuildContext ctx,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          elevation: 1.2,
          scrollable: true,
          title: Text(
            "Cancel the service request?",
            style: TextStyle(color: secondaryColor),
          ),
          content: Text(
            "Are you sure to cancel the request.",
            style: TextStyle(color: secondaryColor),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "ok",
                style: TextStyle(color: secondaryColor),
              ),
              onPressed: () async {
                DateTime createdTime = DateTime.fromMillisecondsSinceEpoch(
                    currentService.createdDate);
                DateTime beforeThirtyMinuteofServiceAccepts =
                    DateTime.fromMillisecondsSinceEpoch(
                            currentService.createdDate)
                        .add(Duration(minutes: 30));
                if ((DateTime.now().isAfter(createdTime) &&
                        DateTime.now()
                            .isBefore(beforeThirtyMinuteofServiceAccepts)) ||
                    currentService.status == ServiceStatus.ACTIVE) {
                  await firebase.lockTheService(currentService.id,
                      status: ServiceStatus.ABORTED);
                  _showSnackbar("Selected service has been cancelled.");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CustomerWelcomeScreen()));
                } else {
                  _showSnackbar(
                      "You can't cancel after 30 min from service request.");
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  showInfoDialog(BuildContext context, String value, {String title}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          elevation: 1.2,
          scrollable: true,
          title: Text(
            title,
            style: TextStyle(color: secondaryColor),
          ),
          content: Text(
            value,
            style: TextStyle(color: secondaryColor),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "ok",
                style: TextStyle(color: secondaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          elevation: 1.2,
          scrollable: true,
          title: Text(
            "Rate rider",
            style: TextStyle(color: secondaryColor),
          ),
          content: Text(
            "",
            style: TextStyle(color: secondaryColor),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "ok",
                style: TextStyle(color: secondaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: primaryColor,
        ),
        elevation: 1.2,
        backgroundColor: secondaryColor,
        centerTitle: true,
        title: Text("Service Detail",
            style: TextStyle(
              color: primaryColor,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomContainer(
              child: Column(
                children: [
                  if (currentService == null)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else ...[
                    getKeyValue(context, "Service Name",
                        value: currentService.serviceName ?? ""),
                    getKeyValue(
                      context,
                      "Created Date",
                      value: formatter.format(
                          DateTime.fromMillisecondsSinceEpoch(
                              currentService.createdDate)),
                    ),
                    getKeyValue(context, "Service Route",
                        value: currentService.route.keys.first ?? ""),
                    getKeyValue(context, "Route Fee",
                        value:
                            "Php. ${currentService.route.values.first.toString()}"),
                    if (currentService.serviceRate ?? false)
                      getKeyValue(context, "Service Charge", value: " Php. 10"),
                    if (currentService.delivery_address != null)
                      getKeyValue(context, "Delivery Address",
                          value: currentService?.delivery_address ?? ""),
                    if (currentService.pick_up_address != null)
                      getKeyValue(context, "Pick-Up Address",
                          value: currentService?.pick_up_address ?? ""),
                    if (currentService.resturant_name != null)
                      getKeyValue(context, "Resturant Name",
                          value: currentService?.resturant_name ?? ""),
                    if (currentService.laundry_shop != null)
                      getKeyValue(context, "Laundry Name",
                          value: currentService?.laundry_shop ?? ""),
                    if (customerInfo != null) ...[
                      getKeyValue(context, "Customer Name",
                          value: customerInfo?.fName ?? ""),
                      if (currentService.contact_num != null ||
                          customerInfo.phoneNumber != null)
                        getKeyValue(context, "Customer contact",
                            value: currentService?.contact_num ??
                                customerInfo?.phoneNumber ??
                                ""),
                      if (customerInfo.address != null)
                        getKeyValue(context, "Customer Address",
                            value: customerInfo?.address ?? ""),
                    ],
                    if (widget.riderInfo != null && !widget.isRider) ...[
                      getKeyValue(context, "Rider Name",
                          value: widget.riderInfo?.fName ?? ""),
                      getKeyValue(context, "Rider Contact",
                          value: widget.riderInfo?.phoneNumber ?? ""),
                      getKeyValue(context, "Rider Address",
                          value: widget.riderInfo?.address ?? ""),
                      getKeyValue(context, "Rider email",
                          value: widget.riderInfo?.email ?? ""),
                    ],
                    getKeyValue(context, "Service status",
                        value: getKeyFromServiceStatusType(
                                currentService.status) ??
                            ""),
                    getKeyValue(context, "Payment Status",
                        value: getKeyFromPaymentStatus(
                                currentService.paymentStatus) ??
                            ""),
                    if (currentService.billType != null)
                      getKeyValue(context, "Bill Type",
                          value: currentService.billType ?? ""),
                    if (currentService.billAmount != null)
                      getKeyValue(context, "Bill Amount",
                          value: "Php. ${currentService.billAmount}" ?? ""),
                    getKeyValue(context, "Total Amount",
                        value: "Php. ${currentService.total_amount}" ?? ""),
                  ],
                  if (currentService.product != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text("Products",
                              style: Theme.of(context)
                                  .accentTextTheme
                                  .subtitle2
                                  .copyWith(color: secondaryColor)),
                        ),
                        GestureDetector(
                          onTap: () => showInfoDialog(
                              context, currentService.product,
                              title: "Products"),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: secondaryColor)),
                            child: Text("Tap to see"),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 8),
                  if (currentService.special_request != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text("special Request",
                              style: Theme.of(context)
                                  .accentTextTheme
                                  .subtitle2
                                  .copyWith(color: secondaryColor)),
                        ),
                        GestureDetector(
                          onTap: () {
                            showInfoDialog(
                                context, currentService.special_request,
                                title: "Special request from customer.");
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: secondaryColor)),
                            child: Text("Tap to see"),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 8,
                  ),
                  if (currentService.necessary_detail != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text("Necessary Details",
                              style: Theme.of(context)
                                  .accentTextTheme
                                  .subtitle2
                                  .copyWith(color: secondaryColor)),
                        ),
                        GestureDetector(
                          onTap: () => showInfoDialog(
                              context, currentService.necessary_detail,
                              title: "Necessary details "),
                          child: Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(color: secondaryColor)),
                            child: Text("Tap to see"),
                          ),
                        ),
                      ],
                    ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text("All currency are in Philippine peso ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: secondaryColor)),
                  ),
                  if (widget.isRider &&
                      currentService.status == ServiceStatus.STARTED)
                    CustomButton(
                      label: "Finish",
                      loading: loading,
                      textColor: primaryColor,
                      onPress: () => showConfirmationDialog(context),
                    ),
                  if (widget.riderInfo != null &&
                      (currentService.status == ServiceStatus.ACTIVE ||
                          currentService.status == ServiceStatus.STARTED))
                    CustomButton(
                      label: "Cancel",
                      loading: loading,
                      textColor: primaryColor,
                      onPress: () => showCancelDialog(context),
                    ),
                  if (!widget.isRider &&
                      currentService.status == ServiceStatus.COMPLETED)
                    CustomButton(
                      label: "Rate current Rider ",
                      textColor: primaryColor,
                      loading: loading,
                      onPress: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RatingScreen(
                                    rider: widget.riderInfo,
                                  )),
                        ),
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
