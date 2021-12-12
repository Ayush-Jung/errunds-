import 'dart:ui';
import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/calculate_price_provider.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/helpers/terms_and_condition_screen.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:errunds_application/screens/customer/search_for_rider_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Service service = Service();
  bool checkedRate = false;
  PriceProvicver priceProvicver;
  bool acceptTerms = false;

  Map<String, int> routes = {
    "Within Poblacion": 35,
    "Poblacion - Dologon": 50,
    "Poblacion - Panadtalan": 40,
    "Poblacion - Base Camp": 40,
    "Anahawon - Poblacion": 40,
    "Anahawon - Base Camp": 45,
    "Anahawon - Camp 1": 45,
    "Anahawon - Panadtalan": 35,
    "Anahawon - Dologon": 45,
    "Base Camp - Camp 1": 50,
    "Base Camp - Panadtalan": 45,
    "Base Camp - Dologon": 65,
    "Camp 1 - Poblacion": 40,
    "Camp 1 - Panadtalan": 45,
    "Camp 1 - Dologon": 65,
    "Panadtalan - Dologon": 45,
    "Panadtalan - Poblacion": 40,
  };
  Map<String, int> utilityRoutes = {
    "Poblacion-FIBECO": 50,
    "Anahawon-FIBECO": 40,
    "Base Camp-FIBECO": 55,
    "Camp 1-FIBECO": 55,
    "Panadtalan-FIBECO": 45,
    "Dologon-FIBECO": 55,
    "Poblacion-Water District": 45,
    "Anahawon-Water District": 50,
    "Base Camp-Water District": 50,
    "Camp 1-Water District": 50,
    "Panadtalan-Water District": 50,
    "Dologon-Water District": 60,
  };
  List<String> selectRoute() {
    if (!widget.ispayBillService) {
      return routes.keys.toList();
    } else {
      return utilityRoutes.keys.toList();
    }
  }

  bool showPrice = false;
  String _currentSelectedValue;
  List<String> paymentsFor = ["Water", "Electricity"];
  String _currentSelectedBillPayment;
  int billCharge = 0;
  Map<String, int> routesPrice = {};

  submitData() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_currentSelectedValue == null) {
        showSnackBar("Please select a route.");
      } else if (!checkedRate) {
        showSnackBar("Please accpect the express rate.");
      } else if (widget.ispayBillService &&
          _currentSelectedBillPayment == null) {
        showSnackBar("Please select a payment for.");
      } else if (!acceptTerms) {
        showSnackBar("Please accept terms and condition.");
      } else {
        openDialog();
      }
    }
  }

  openDialog() async {
    await showConfirmationDialog(onYes: () async {
      try {
        service.serviceName = widget.title;
        service.total_amount = priceProvicver.totalAmount.toString();
        service.createdDate = DateTime.now().millisecondsSinceEpoch;
        String serviceId = await firebase.setService(service);
        await showScannerDialog(context, serviceId);
      } catch (e) {
        showSnackBar(
            e.message ?? "Unable to perform the action. Please try again!");
      }
    }, onNo: () {
      Navigator.pop(context);
    });
  }

  Future<bool> showConfirmationDialog({
    Function onYes,
    Function onNo,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          title:
              Text("Rider Request?", style: TextStyle(color: secondaryColor)),
          content: Text("Look for a rider?",
              style: TextStyle(color: secondaryColor)),
          actions: <Widget>[
            TextButton(
              child: Text("Yes", style: TextStyle(color: secondaryColor)),
              onPressed: () {
                Navigator.pop(context);
                onYes?.call();
              },
            ),
            TextButton(
              child: Text("No", style: TextStyle(color: secondaryColor)),
              onPressed: () {
                Navigator.pop(context);
                onNo.call();
              },
            )
          ],
        );
      },
    );
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: secondaryColor),
      ),
      backgroundColor: primaryColor,
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    priceProvicver = Provider.of<PriceProvicver>(context);
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
                          color: secondaryColor,
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
                decoration: BoxDecoration(color: secondaryColor),
                child: Form(
                  key: _formKey,
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
                                fillColor: primaryColor,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: secondaryColor,
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
                                  hint: Text(
                                    "Select route",
                                    style: TextStyle(color: secondaryColor),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  style: TextStyle(color: secondaryColor),
                                  isDense: true,
                                  iconEnabledColor: secondaryColor,
                                  dropdownColor: primaryColor,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _currentSelectedValue = newValue;
                                      Map<String, int> a = {};
                                      a[newValue] = routes[newValue] ??
                                          utilityRoutes[newValue];
                                      service.route = a;
                                      priceProvicver.setPriceAccordingToRoute(
                                          a.values.first);
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: selectRoute().map((String value) {
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
                                  fillColor: primaryColor,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: secondaryColor,
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
                                    value: _currentSelectedBillPayment,
                                    iconEnabledColor: secondaryColor,
                                    style: TextStyle(color: secondaryColor),
                                    hint: Text(
                                      "Select Payment",
                                      style: TextStyle(color: secondaryColor),
                                    ),
                                    isDense: true,
                                    dropdownColor: primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _currentSelectedBillPayment = newValue;
                                        service.billType = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: paymentsFor.map((String value) {
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
                            textCapitalization: TextCapitalization.words,
                            style: const TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              fillColor: primaryColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: secondaryColor,
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
                            onChanged: (value) {
                              service.pick_up_address = (value ?? "").trim();
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
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              fillColor: primaryColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: secondaryColor,
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
                            onChanged: (value) {
                              service.delivery_address = (value ?? "").trim();
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
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: primaryColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: secondaryColor,
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
                            onChanged: (value) {
                              setState(() {
                                service.billAmount = (value ?? "").trim();
                                billCharge = int.parse(value);
                                priceProvicver.setAmount(billCharge);
                              });
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
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              fillColor: primaryColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: secondaryColor,
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
                            onChanged: (value) {
                              service.contact_num = (value ?? "").trim();
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
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              fillColor: primaryColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: secondaryColor,
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
                            onChanged: (value) {
                              service.laundry_shop = (value ?? "").trim();
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
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              fillColor: primaryColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: secondaryColor,
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
                            onChanged: (value) {
                              service.resturant_name = (value ?? "").trim();
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
                              fillColor: primaryColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: secondaryColor,
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
                            onChanged: (value) {
                              service.necessary_detail = (value ?? "").trim();
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
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              fillColor: primaryColor,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: secondaryColor,
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
                            onChanged: (value) {
                              service.product = (value ?? "").trim();
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
                                checkColor: secondaryColor,
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                    width: 2.0,
                                    color: primaryColor,
                                  ),
                                ),
                                value: checkedRate,
                                onChanged: (bool value) {
                                  checkedRate = value;
                                  priceProvicver.setExpressRate(10);
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
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            fillColor: primaryColor,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: secondaryColor,
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
                          onChanged: (value) {
                            service.special_request = (value ?? "").trim();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TOTAL SERVICE FEE:",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Text(
                                priceProvicver.totalAmount.toString(),
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(left: 18),
                        child: Row(
                          children: [
                            Checkbox(
                              side:
                                  MaterialStateBorderSide.resolveWith((states) {
                                return BorderSide(
                                    color: primaryColor, width: 21.3);
                              }),
                              activeColor: Colors.redAccent,
                              fillColor: MaterialStateProperty.all<Color>(
                                  primaryColor),
                              checkColor: secondaryColor,
                              value: acceptTerms,
                              onChanged: (value) {
                                setState(() {
                                  acceptTerms = value;
                                });
                              },
                            ),
                            RichText(
                              text: TextSpan(text: "", children: [
                                TextSpan(
                                    text: "I agree with ",
                                    style: TextStyle(color: primaryColor)),
                                TextSpan(
                                    text: "Terms & Conditions.",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  TermsAndConditionScreen(
                                                parcel: widget.isParcelService,
                                                food_delivery:
                                                    widget.isFoodDelivery,
                                                grocery:
                                                    widget.isGroceryService,
                                                postal: widget.isPostalService,
                                                delivery:
                                                    widget.isLaundryservice,
                                                utility:
                                                    widget.ispayBillService,
                                              ),
                                            ),
                                          ),
                                    style: TextStyle(
                                      color: primaryColor,
                                      decoration: TextDecoration.underline,
                                    ))
                              ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                        child: CustomButton(
                            label: "Look for a Rider",
                            color: primaryColor,
                            textColor: secondaryColor,
                            labelSize: 18,
                            onPress: submitData),
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
