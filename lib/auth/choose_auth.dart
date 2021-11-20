import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthChooser extends StatefulWidget {
  const AuthChooser({Key? key}) : super(key: key);

  @override
  _AuthChooserState createState() => _AuthChooserState();
}

class _AuthChooserState extends State<AuthChooser> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/logo-errunds.svg",
                height: size.height * 0.3,
                width: size.width * 0.4,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  label: "Customer",
                  color: Colors.red,
                ),
                CustomButton(
                  label: "Driver",
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
