import 'package:errunds_application/helpers/custom_text_field.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/errund_user.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatefulWidget {
  final Service service;
  final ErrundUser customer;
  const ServiceDetailScreen({Key key, this.service, this.customer})
      : super(key: key);

  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  Service currentService;
  ErrundUser customerInfo;
  @override
  void initState() {
    setState(() {
      currentService = widget.service;
      customerInfo = widget.customer;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Detail"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (currentService == null || customerInfo == null)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else ...[
                getKeyValue(context, "Service Name",
                    value: currentService.serviceName ?? ""),
                getKeyValue(context, "Customer Name",
                    value: customerInfo?.fName ?? ""),
                getKeyValue(context, "Customer contact",
                    value: customerInfo?.phoneNumber ?? ""),
                getKeyValue(context, "Customer Address",
                    value: customerInfo?.address ?? ""),
                getKeyValue(context, "Pick-Up Address",
                    value: currentService?.pick_up_address ?? ""),
                getKeyValue(context, "Service status",
                    value: getKeyFromServiceStatusType(currentService.status) ??
                        ""),
                getKeyValue(context, "Payment Status",
                    value:
                        getKeyFromPaymentStatus(currentService.paymentStatus) ??
                            ""),
                getKeyValue(context, "Service Amount",
                    value: currentService.total_amount ?? ""),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
