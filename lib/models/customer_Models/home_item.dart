import 'package:flutter/cupertino.dart';

class HomeItem {
  HomeItem({
    this.icondata,
    this.title,
    this.callback,
  });
  String title;
  IconData icondata;
  VoidCallback callback;
}
