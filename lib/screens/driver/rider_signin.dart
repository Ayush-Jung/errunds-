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
                          child: CustomTextField(
                            label: "Email",
                            initialValue: "ayush_errunds@gmail.com",
                            textInputType: TextInputType.emailAddress,
                            onvalidate: (value) {
                              if (value == null || value.isEmpty) {
                                return "Mandatory field";
                              } else if (!isEmail(value.trim())) {
                                return "Invalid email";
                              } else {
                                return null;
                              }
                            },
                            saved: (value) {
                              setState(() {
                                email = value!.trim();
                              });
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16,
                        ),
                        child: CustomTextField(
                          label: "Password",
                          initialValue: "gotocook1",
                          obscureText: true,
                          onvalidate: (value) {
                            if (value == null || value.isEmpty) {
                              return "Mandatory field";
                            }
                          },
                          saved: (value) {
                            setState(() {
                              password = value!.trim();
                            });
                          },
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
    );
  }
}
