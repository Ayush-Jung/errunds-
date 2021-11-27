import 'package:errunds_application/helpers/firebase.dart';
import 'package:flutter/material.dart';

class RiderHomePage extends StatefulWidget {
  const RiderHomePage({Key key}) : super(key: key);

  @override
  _RiderHomePageState createState() => _RiderHomePageState();
}

class _RiderHomePageState extends State<RiderHomePage> {
  @override
  void initState() {
    super.initState();
    print(firebase.errundUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => firebase.logOut(),
          child: Container(
            alignment: Alignment.center,
            child: Text("data"),
          ),
        ),
      ),
    );
  }
}
