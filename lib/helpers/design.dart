import 'package:errunds_application/helpers/colors.dart';
import 'package:flutter/material.dart';

Widget errunds = RichText(
  text: TextSpan(
    style: const TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
    text: "",
    children: [
      TextSpan(
        text: "E-R",
        style: TextStyle(
          color: buttonBackgroundColor,
        ),
      ),
      TextSpan(
        text: "RUN",
        style: TextStyle(
          color: Colors.red[400],
        ),
      ),
      TextSpan(
        text: "DS",
        style: TextStyle(
          color: buttonBackgroundColor,
        ),
      ),
    ],
  ),
);
bool isEmail(String em) => RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
    .hasMatch(em);
