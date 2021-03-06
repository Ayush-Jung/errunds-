import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthChooser extends StatefulWidget {
  const AuthChooser({Key key}) : super(key: key);

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
        child: Container(
          constraints: BoxConstraints(
            maxHeight: size.height,
            minWidth: size.width,
          ),
          decoration: BoxDecoration(
            gradient: linearGradient,
            color: primaryColor,
          ),
          child: Column(
            children: [
              const Spacer(),
              SvgPicture.asset(
                "assets/logo-errunds.svg",
                color: Colors.red[400],
                height: size.height * 0.2,
                width: size.width * 0.2,
              ),
              errunds,
              const Spacer(),
              Container(
                margin: EdgeInsets.fromLTRB(
                    size.width * 0.3, 8, size.width * 0.3, 8),
                child: CustomButton(
                  label: "CUSTOMER",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LogInScreen(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                padding: const EdgeInsets.all(6),
                margin: EdgeInsets.only(
                    left: size.width * 0.3, right: size.width * 0.3),
                child: CustomButton(
                  label: "RIDER",
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LogInScreen(
                          isRider: true,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
