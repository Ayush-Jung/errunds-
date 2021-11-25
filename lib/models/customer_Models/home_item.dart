import 'package:flutter/cupertino.dart';

class HomeItem extends ChangeNotifier {
  HomeItem({
    this.icondata,
    this.title,
    this.callback,
  });
  String title;
  BuildContext _ctx;
  IconData icondata;
  VoidCallback callback;

  setContext(BuildContext context) {
    _ctx = context;
    notifyListeners();
  }

  get context => _ctx;
}
