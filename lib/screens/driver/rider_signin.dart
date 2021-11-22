import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/custom_text_field.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RiderSignIn extends StatefulWidget {
  const RiderSignIn({Key? key}) : super(key: key);

  @override
  State<RiderSignIn> createState() => _RiderSignInState();
}

class _RiderSignInState extends State<RiderSignIn> {
  String? email;
  String? password;
  bool loading = false;
  final GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomPaint(
          painter: BackgroundPaint(),
          foregroundPainter: CurvedPainter(),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
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
                          child:
                              //  CustomTextField(
                              //   label: "Email",
                              //   initialValue: "ayush_errunds@gmail.com",
                              //   textInputType: TextInputType.emailAddress,
                              //   onvalidate: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return "Mandatory field";
                              //     } else if (!isEmail(value.trim())) {
                              //       return "Invalid email";
                              //     } else {
                              //       return null;
                              //     }
                              //   },
                              //   saved: (value) {
                              //     setState(() {
                              //       email = value!.trim();
                              //     });
                              //   },
                              // ),
                              TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  borderSide: BorderSide(width: 4),
                                ),
                                labelText: 'Email',
                                hintText: 'Enter secure password'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16,
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                hintText: 'Enter secure password'),
                          ),
                          // CustomTextField(
                          //   label: "Password",
                          //   initialValue: "gotocook1",
                          //   obscureText: true,
                          //   onvalidate: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return "Mandatory field";
                          //     }
                          //   },
                          //   saved: (value) {
                          //     setState(() {
                          //       password = value!.trim();
                          //     });
                          //   },
                          // ),
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
                            onPress: () {},
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

    canvas.drawCircle(offset, 3, paint);
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

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
