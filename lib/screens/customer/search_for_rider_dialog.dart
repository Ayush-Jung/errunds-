import 'package:errunds_application/screens/customer/show_online_rider.dart';
import 'package:flutter/material.dart';

Future<void> showScannerDialog(BuildContext context, String serviceId) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return ScanOnlineRider(
        serviceId: serviceId,
      );
    },
  );
}
