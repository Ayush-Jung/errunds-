// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/screens/auth/signup_screen.dart';
import 'package:errunds_application/screens/customer/customer_welcome_screen.dart';
import 'package:errunds_application/screens/driver/rider_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key key, this.isRider = false}) : super(key: key);
  final bool isRider;

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  String email;
  String password, companyId;
  bool showPassword = false;
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  login() {
    if (_formKey.currentState.validate()) _formKey.currentState.save();
    if (email == null || password == null) {
      showSnackBar("Mandatory Fields.");
    } else {
      getLoading(true);
      firebase
          .loginUser(
        email,
        password,
      )
          .then((value) {
        if (value == null) {
          getLoading(false);
          showSnackBar("Unable to login");
        } else if (value != null && companyId == null) {
          getLoading(false);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const CustomerWelcomeScreen()),
              (route) => false);
        } else {
          getLoading(false);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const RiderHomePage()),
              (route) => false);
        }
      }).catchError((e) {
        showSnackBar(e.toString());
        getLoading(false);
      });
    }
  }

  getLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  showSnackBar(String message) {
    _key.currentState.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: primaryColor,
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
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
                      if (widget.isRider)
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
                                borderSide: BorderSide(width: 4),
                              ),
                              labelText: 'Password',
                              hintText: 'Enter secure password'),
                          validator: (value) {
                            value = value.trim();
                            if (value.isEmpty) {
                              return "Mandatory Field";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = (value ?? "").trim();
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
                                builder: (_) => SignUpScreen(
                                  isRider: widget.isRider,
                                ),
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
                          onPress: login,
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
