import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/design.dart';
import 'package:errunds_application/models/customer_Models/rider_Models/rider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomerSignUp extends StatefulWidget {
  const CustomerSignUp({Key key}) : super(key: key);

  @override
  _CustomerSignUpState createState() => _CustomerSignUpState();
}

class _CustomerSignUpState extends State<CustomerSignUp> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final retypedPasswordController = TextEditingController();
  bool loading = false;
  bool acceptCondition = false;
  String email = "", password = "", cpassword = "";
  Rider rider;

  bool showPassword = false;
  bool showConfirmPassword = false;

  submitRequest() {
    if (_formKey.currentState.validate()) _formKey.currentState.save();
    if (email == null || password == null || cpassword == null) {
      showSnackBar("Empty fields.");
    }
    if (password != cpassword) {
      showSnackBar("Password doesnot matched.");
    } else {
      getLoading(true);
      // firebase.riderSignUp(email, password ,).then((value) {
      //   getLoading(false);
      //   if (value != null) {
      //     Navigator.pushNamedAndRemoveUntil(
      //         context, "/travelinfoStep", (predicate) => false);
      //   } else {
      //     print("failed");
      //     return;
      //   }
      // });
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
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5.0),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(18),
                                    ),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(18),
                                    ),
                                    borderSide:
                                        BorderSide(width: 4, color: Colors.red),
                                  ),
                                  label: Text(
                                    "First Name",
                                    style:
                                        TextStyle(color: buttonBackgroundColor),
                                  ),
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
                                rider.fName = (value ?? "").trim();
                              },
                            )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 5.0),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  borderSide:
                                      BorderSide(width: 4, color: Colors.red),
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
                              rider.lName = (value ?? "").trim();
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
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 5.0),
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
                        rider.phoneNumber = (value ?? "").trim();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 5.0),
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
                        rider.email = (value ?? "").trim();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 5.0),
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
                        rider.companyId = (value ?? "").trim();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 5.0),
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
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 5.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 5.0),
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
