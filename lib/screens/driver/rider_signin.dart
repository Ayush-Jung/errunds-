import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/screens/driver/rider_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RiderSignIn extends StatefulWidget {
  const RiderSignIn({Key key}) : super(key: key);

  @override
  State<RiderSignIn> createState() => _RiderSignInState();
}

class _RiderSignInState extends State<RiderSignIn> {
  String email;
  String password;
  bool loading = false;
  String companyId;
  bool showPassword = false;
  final GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          decoration: BoxDecoration(
            gradient: linearGradient,
          ),
          child: SafeArea(
            child: Column(
              children: [
                const Spacer(),
                errunds,
                const Spacer(),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 5.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                borderSide: BorderSide(width: 4),
                              ),
                              labelText: 'Email',
                              hintText: 'Enter Email'),
                          validator: (value) {
                            value = value.trim();
                            if (value.isEmpty) {
                              return "Mandatory Field";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            email = (value ?? "").trim();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16,
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 5.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              labelText: 'company Id',
                              hintText: 'Enter company Id'),
                          validator: (value) {
                            value = value.trim();
                            if (value.isEmpty) {
                              return "Mandatory Field";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            companyId = (value ?? "").trim();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              fillColor: primaryColor,
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 5.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: Icon(showPassword
                                    ? MdiIcons.eye
                                    : MdiIcons.eyeOff),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                              labelText: 'Password',
                              hintText: 'Enter secure password'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Mandatory Field";
                            }

                            if (value.length > 20) {
                              return "password too long";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = value;
                          },
                          obscureText: !showPassword,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8),
                        child: CustomButton(
                          label: "SIGN-UP",
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RiderSignUp(),
                              ),
                            );
                          },
                          color: Colors.yellow[700],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: CustomButton(
                          label: "LOG-IN",
                          onPress: () {},
                          loading: loading,
                          color: Colors.yellow[700],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SvgPicture.asset(
                    "assets/logo-errunds.svg",
                    color: Colors.red[300],
                    height: size.height * 0.2,
                    width: size.width * 0.2,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    Offset offset = Offset(size.height, size.height);

    canvas.drawLine(offset, offset, paint);
  }

  @override
  bool shouldRepaint(BackgroundPaint oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BackgroundPaint oldDelegate) => false;
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.1);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 1.2,
      size.width,
      size.height,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
