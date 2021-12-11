import 'package:errunds_application/helpers/colors.dart';
import 'package:errunds_application/helpers/terms_for_signup.dart';
import 'package:flutter/material.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          title: Center(
            child: Text(
              "Terms and Conditions.",
              style: TextStyle(color: primaryColor),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(terms),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(secondaryColor)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("I agree the terms and conditions"))
              ],
            ),
          ),
        ),
      );
}
