import 'package:flutter/material.dart';

class CustomerHomeScren extends StatefulWidget {
  const CustomerHomeScren({Key key, this.active}) : super(key: key);
  final bool active;

  @override
  _CustomerHomeScrenState createState() => _CustomerHomeScrenState();
}

class _CustomerHomeScrenState extends State<CustomerHomeScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const Text("data"),
          ],
        ),
      )),
    );
  }
}
