import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/custom_item/custom_container.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/custom_text_field.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:errunds_application/screens/driver/rider_welcome_page.dart';
import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatefulWidget {
  final Service service;
  final ErrundUser customer;
  final ErrundUser riderInfo;
  const ServiceDetailScreen(
      {Key key, this.service, this.riderInfo, this.customer})
      : super(key: key);

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  Service currentService;
  ErrundUser customerInfo;
  bool loading = false;
  @override
  void initState() {
    setState(() {
      currentService = widget.service;
      customerInfo = widget.customer;
    });

    super.initState();
  }

  showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Finish Service?"),
          content: const Text(
              "payment is not completed. Do you want to complete with cash?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes"),
              onPressed: () async {
                await firebase.unLockTheService(currentService.id);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const RiderWelcomeScreen()),
                    (route) => false);
              },
            ),
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonBackgroundColor,
        title: const Text("Service Detail"),
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
                    if (customerInfo != null) ...[
                      getKeyValue(context, "Customer Name",
                          value: customerInfo?.fName ?? ""),
                      getKeyValue(context, "Customer contact",
                          value: customerInfo?.phoneNumber ?? ""),
                      getKeyValue(context, "Customer Address",
                          value: customerInfo?.address ?? ""),
                      getKeyValue(context, "Pick-Up Address",
                          value: currentService?.pick_up_address ?? ""),
                    ],
                    if (widget.riderInfo != null) ...[
                      getKeyValue(context, "Rider Name",
                          value: widget.riderInfo?.fName ?? ""),
                      getKeyValue(context, "Customer Contact",
                          value: widget.riderInfo?.phoneNumber ?? ""),
                      getKeyValue(context, "Rider Address",
                          value: widget.riderInfo?.address ?? ""),
                    ],
                    getKeyValue(context, "Service status",
                        value: getKeyFromServiceStatusType(
                                currentService.status) ??
                            ""),
                    getKeyValue(context, "Payment Status",
                        value: getKeyFromPaymentStatus(
                                currentService.paymentStatus) ??
                            ""),
                    getKeyValue(context, "Service Amount",
                        value: currentService.total_amount ?? ""),
                  ],
                  if (widget.riderInfo == null)
                    CustomButton(
                      label: "Finish",
                      loading: loading,
                      onPress: () => showConfirmationDialog(context),
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
