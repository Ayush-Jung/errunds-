import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  bool checkedRate = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: Colors.red[300],
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SvgPicture.asset(
                        "assets/logo-errunds.svg",
                        color: Colors.red[300],
                        height: size.width * 0.3,
                        width: size.width * 0.3,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: buttonBackgroundColor),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 8, 0, 2),
                        child: Text(
                          "Route",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 16),
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: buttonBackgroundColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                borderSide: BorderSide(color: Colors.white)),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                          ),
                          validator: (value) {
                            value = value.trim();
                            if (value.isEmpty) {
                              return "Mandatory Field";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // email = (value ?? "").trim();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 8, 0, 2),
                        child: Text(
                          "Pick-Up Address",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 16),
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: buttonBackgroundColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                borderSide: BorderSide(color: Colors.white)),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                          ),
                          validator: (value) {
                            value = value.trim();
                            if (value.isEmpty) {
                              return "Mandatory Field";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // email = (value ?? "").trim();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 8, 0, 2),
                        child: Text(
                          "Delivery Address",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 16),
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: buttonBackgroundColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                borderSide: BorderSide(color: Colors.white)),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                          ),
                          validator: (value) {
                            value = value.trim();
                            if (value.isEmpty) {
                              return "Mandatory Field";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // email = (value ?? "").trim();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 8, 0, 2),
                        child: Text(
                          "Contact No",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 16),
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: buttonBackgroundColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                borderSide: BorderSide(color: Colors.white)),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                          ),
                          validator: (value) {
                            value = value.trim();
                            if (value.isEmpty) {
                              return "Mandatory Field";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // email = (value ?? "").trim();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 8, 0, 2),
                        child: Text(
                          "Laundry Shop",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 16),
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: buttonBackgroundColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                borderSide: BorderSide(color: Colors.white)),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                          ),
                          validator: (value) {
                            value = value.trim();
                            if (value.isEmpty) {
                              return "Mandatory Field";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // email = (value ?? "").trim();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 0, 0, 2),
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                activeColor: primaryColor,
                                checkColor: Colors.white,
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => const BorderSide(
                                      width: 2.0, color: Colors.white),
                                ),
                                value: checkedRate,
                                onChanged: (bool value) {
                                  checkedRate = value;
                                  setState(() {});
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("Express Rate (P10)",
                                style: TextStyle(
                                    color: primaryColor, fontSize: 18))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 4, 0, 2),
                        child: Text(
                          "Special Request",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 16),
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: buttonBackgroundColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                borderSide: BorderSide(color: Colors.white)),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                            ),
                          ),
                          validator: (value) {
                            value = value.trim();
                            if (value.isEmpty) {
                              return "Mandatory Field";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // email = (value ?? "").trim();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 4, 0, 2),
                        child: Row(
                          children: [
                            Text(
                              "SERVICE FEE TOTAL:",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 80),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Text(
                                "500",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                              //TODO later add dynamic fee from backend.
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                        child: CustomButton(
                          label: "Look for a Rider",
                          color: primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
