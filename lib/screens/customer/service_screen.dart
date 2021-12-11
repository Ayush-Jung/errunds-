import 'package:errunds_application/custom_item/custom_button.dart';
import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/models/customer_Models/service.dart';
import 'package:errunds_application/screens/customer/search_for_rider_dialog.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Service service = Service();
  bool checkedRate = false;
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

  submitData() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await showConfirmationDialog(onYes: () async {
        try {
          service.serviceName = widget.title;
          service.total_amount = calculateTotalPrice();
          service.createdDate = DateTime.now().millisecondsSinceEpoch;
          String serviceId = await firebase.setService(service);
          await showScannerDialog(context, serviceId);
        } catch (e) {
          showSnackBar(
              e.message ?? "Unable to perform the action. Please try again!");
        }
      });

      Navigator.pop(context);
    }
  }

  String calculateTotalPrice() {
    if (!widget.ispayBillService) {
      int price = routes[_currentSelectedValue] ?? 0 + 10;
      return price.toString();
    } else {
      int price = utilityRoutes[_currentSelectedValue] ?? 0 + billCharge + 10;
      return price.toString();
    }
  }

  Future<bool> showConfirmationDialog({
    VoidCallback onYes,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Rider Request?"),
          content: const Text("Are you sure?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.pop(context, true);
                onYes?.call();
              },
            ),
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: primaryColor,
      duration: const Duration(seconds: 2),
    ));
  }

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
                                hintText: "Select route",
                                fillColor: Colors.white,
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
                                  hint: const Text("Select route"),
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _currentSelectedValue = newValue;
                                      Map<String, int> a = {};
                                      a[newValue] = routes[newValue] ??
                                          utilityRoutes[newValue];
                                      service.route = a;
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
                                  fillColor: Colors.white,
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
                                    hint: const Text("Select Payment"),
                                    isDense: true,
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
                              fillColor: Colors.white,
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
                              fillColor: Colors.white,
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
                              fillColor: Colors.white,
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
                              fillColor: Colors.white,
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
                              fillColor: Colors.white,
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
                              fillColor: Colors.white,
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
                              fillColor: Colors.white,
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
                            // validator: (value) {
                            //   value = value.trim();
                            //   if (value.isEmpty) {
                            //     return "Mandatory Field";
                            //   }
                            //   return null;
                            // },
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
                              fillColor: Colors.white,
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
                                checkColor: secondaryColor,
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => const BorderSide(
                                      width: 2.0, color: Colors.white),
                                ),
                                value: checkedRate,
                                onChanged: (bool value) {
                                  checkedRate = value;
                                  showPrice = true;
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
                            fillColor: Colors.white,
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
                          // validator: (value) {
                          //   value = value.trim();
                          //   if (value.isEmpty) {
                          //     return "Mandatory Field";
                          //   }
                          //   return null;
                          // },
                          onChanged: (value) {
                            service.special_request = (value ?? "").trim();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 4, 0, 2),
                        child: Row(
                          children: [
                            Text(
                              "TOTAL SERVICE FEE:",
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
                                showPrice ? calculateTotalPrice() : "" ?? "",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(50, 10, 50, 30),
                        child: CustomButton(
                            label: "Look for a Rider",
                            color: Colors.white,
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
