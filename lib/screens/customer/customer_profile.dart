import 'package:errunds_application/helpers/colors.dart';
import 'package:flutter/material.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({Key key, this.active}) : super(key: key);
  final bool active;

  @override
  _CustomerProfileScreenState createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 2,
          child: Container(
            color: Colors.black,
            height: 50,
            width: 50,
          ),
        ),
        Container(
          color: const Color(0xFFF5E97C),
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.height / 2,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 2,
          child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.height / 2,
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              color: buttonBackgroundColor,
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.height / 2,
            ))
      ],
    );
  }
}
