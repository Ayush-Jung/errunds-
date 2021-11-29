import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen(
      {Key key,
      this.title,
      this.isLaundryservice = false,
      this.isFoodDelivery = false,
      this.isPostalService = false,
      this.isGroceryService = false,
      this.ispayBillService = false,
      this.isParcelService = false})
      : super(key: key);
  final String title;
  final bool isLaundryservice;
  final bool isParcelService;
  final bool isFoodDelivery;
  final bool isPostalService;
  final bool isGroceryService;
  final bool ispayBillService;

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  bool checkedRate = false;
  List<String> routes = [
    "Poblacion - Dologon",
    "Poblacion - Panadtalan",
    "Poblacion - Base Camp",
    "Anahawon - Poblacion",
    "Anahawon - Camp 1",
    "Anahawon - Panadtalan",
    "Anahawon - Dologon",
    "Base Camp - Camp 1",
    "Base Camp - Panadtalan",
    "Base Camp - Dologon",
    "Camp 1 - Poblacion",
    "Camp 1 - Panadtalan",
    "Camp 1 - Dologon",
    "Panadtalan - Dologon",
    "Panadtalan - Poblacion",
  ];
  List<String> utilityRoutes = [
    "Poblacion - FIBECO",
    "Anahawon - FIBECO",
    "Camp 1 - FIBECO",
    "Panadtalan - FIBECO",
    "Dologon - FIBECO",
    "Poblacion - Water District",
    "Anahawon - Water District",
    "Base Camp - Water District",
    "Camp 1 - Water District",
    "Panadtalan - Water District",
    "Dologon -  Water District",
  ];
  String _currentSelectedValue;

  String _currentSelectedValueUtility;

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
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                hintText: "Select route",
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
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _currentSelectedValue,
                                  hint: const Text("Select route"),
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _currentSelectedValue = newValue;
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: routes.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (widget.ispayBillService) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 8, 0, 2),
                          child: Text(
                            "Payment Bills",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
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
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(18),
                                    ),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _currentSelectedValueUtility,
                                    hint: const Text("Select Payment"),
                                    isDense: true,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _currentSelectedValueUtility = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: utilityRoutes.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      if (widget.isFoodDelivery ||
                          widget.isLaundryservice ||
                          widget.isParcelService ||
                          widget.isPostalService) ...[
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
                      ],
                      if (widget.isFoodDelivery ||
                          widget.isLaundryservice ||
                          widget.isParcelService ||
                          widget.isGroceryService ||
                          widget.isPostalService) ...[
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
                      ],
                      if (widget.ispayBillService) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 8, 0, 2),
                          child: Text(
                            "Amount",
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
                      ],
                      if (widget.isFoodDelivery ||
                          widget.isLaundryservice ||
                          widget.isParcelService ||
                          widget.isPostalService) ...[
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
                      ],
                      if (widget.isLaundryservice) ...[
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
                      ],
                      if (widget.isFoodDelivery) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 8, 0, 2),
                          child: Text(
                            "Resturant Name",
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
                      ],
                      if (widget.ispayBillService) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 8, 0, 2),
                          child: Text(
                            "Necessary Details (Account No.., etc)",
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
                            maxLines: 10,
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
                      ],
                      if (widget.isGroceryService) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 8, 0, 2),
                          child: Text(
                            "List of Products",
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
                            maxLines: 10,
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
                      ],
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
