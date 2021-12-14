import 'package:flutter/cupertino.dart';

class PriceProvicver extends ChangeNotifier {
  int _amount = 0;
  int _expressRate = 0;
  int _priceAccordingToRoute = 0;

  int get totalAmount => _amount + _expressRate + _priceAccordingToRoute;

  setAmount(int amount) {
    _amount = amount;
    notifyListeners();
  }

  set setTotalAmount(int value) {
    _amount = value;
    _expressRate = value;
    _priceAccordingToRoute = value;
    notifyListeners();
  }

  setExpressRate(int rate) {
    _expressRate = rate;
    notifyListeners();
  }

  setPriceAccordingToRoute(int rate) {
    _priceAccordingToRoute = rate;
    print(rate);
    notifyListeners();
  }
}
