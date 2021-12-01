import 'package:errunds_application/screens/customer/show_online_rider.dart';
import 'package:flutter/material.dart';

Future<bool> showScannerDialog(BuildContext context, String serviceId) {
  return showDialog<bool>(
    context: context,
    builder: (_) {
      return ScanOnlineRider(
        serviceId: serviceId,
      );
    },
  );
}
