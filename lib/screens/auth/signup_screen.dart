import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/screens/customer/customer_welcome_screen.dart';
import 'package:errunds_application/screens/driver/rider_home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key, this.isRider}) : super(key: key);
  final bool isRider;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final retypedPasswordController = TextEditingController();
  bool loading = false;
  bool acceptCondition = false;
  String email = "", password = "", cpassword = "";
  String fName, lName, phoneNumber, companyId;

  bool showPassword = false;
  bool showConfirmPassword = false;

  submitRequest() {
    if (_formKey.currentState.validate()) _formKey.currentState.save();
    if (email == null || password == null || cpassword == null) {
      showSnackBar("Mandatory Field.");
    }
    if (password != cpassword) {
      showSnackBar("Password doesnot matched.");
    }
    if (!acceptCondition) {
      showSnackBar("Please accept the terms and conditions.");
    } else {
      getLoading(true);
      firebase
          .signupUser(email, password, phoneNumber, fName, lName,
              companyId: companyId, isRider: widget.isRider)
          .then((value) {
        if (widget.isRider && value != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const RiderHomePage()),
              (route) => false);
        } else if (value != null && !widget.isRider) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const CustomerWelcomeScreen()),
              (route) => false);
        }
      }).catchError(
        (e) => showSnackBar(e.toString()),
      );
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
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          decoration: BoxDecoration(
            gradient: linearGradient,
          ),
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: errunds,
                    heightFactor: 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: buttonBackgroundColor,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 4),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 4.0),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(18),
                                    ),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(18),
                                    ),
                                    borderSide: BorderSide(width: 4),
                                  ),
                                  labelText: "First Name",
                                  hintText: "Enter first name"),
                              validator: (value) {
                                value = value.trim();
                                if (value == null) return null;
                                if (value.isEmpty) {
                                  return "Mandatory Field";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                fName = (value ?? "").trim();
                              },
                            )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 4),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 4.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  borderSide: BorderSide(width: 4),
                                ),
                                label: Text(
                                  "Last Name",
                                  style:
                                      TextStyle(color: buttonBackgroundColor),
                                ),
                                hintText: "Enter last name"),
                            validator: (value) {
                              value = value.trim();
                              if (value.isEmpty) {
                                return "Mandatory Field";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              lName = (value ?? "").trim();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 4),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 4.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                            borderSide: BorderSide(width: 4),
                          ),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: buttonBackgroundColor),
                          hintText: 'Phone Number'),
                      validator: (value) {
                        value = value.trim();
                        if (value.isEmpty) {
                          return "Mandatory Field";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        phoneNumber = (value ?? "").trim();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 4),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 4.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                            borderSide: BorderSide(width: 4),
                          ),
                          labelText: 'E-mail',
                          labelStyle: TextStyle(color: buttonBackgroundColor),
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
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  const BorderSide(color: Colors.red, width: 4),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 4.0),
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              borderSide: BorderSide(width: 4),
                            ),
                            labelText: 'Company Id',
                            labelStyle: TextStyle(color: buttonBackgroundColor),
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
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 4),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 4.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                            borderSide: BorderSide(width: 4),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: buttonBackgroundColor),
                          hintText: 'Enter Password'),
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 4),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 4.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                            borderSide: BorderSide(width: 4),
                          ),
                          label: Text(
                            'Re-type Password',
                            style: TextStyle(color: buttonBackgroundColor),
                          ),
                          hintText: 'Re- type Password'),
                      validator: (value) {
                        value = value.trim();
                        if (value.isEmpty) {
                          return "Mandatory Field";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        cpassword = (value ?? "").trim();
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 18),
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: primaryColor,
                          value: acceptCondition,
                          onChanged: (value) {
                            setState(() {
                              acceptCondition = value;
                            });
                          },
                        ),
                        RichText(
                          text: TextSpan(text: "", children: [
                            const TextSpan(
                                text: "I agree with ",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: "Terms & Conditions.",
                                recognizer: TapGestureRecognizer()
                                  ..onTap =
                                      () => print("show terms and conditions."),
                                style: TextStyle(
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                ))
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                        width: MediaQuery.of(context).size.width * 0.3,
                        color: primaryColor,
                        textColor: buttonBackgroundColor,
                        onPress: submitRequest,
                        label: "SIGN-UP",
                        loading: loading,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
