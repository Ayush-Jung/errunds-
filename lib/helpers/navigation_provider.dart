import 'package:flutter/cupertino.dart';

class NavigationProvider extends ChangeNotifier {
  int currentIndex = 0;
  setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
