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

  setExpressRate(int rate) {
    _expressRate = rate;
    notifyListeners();
  }

  setPriceAccordingToRoute(int rate) {
    _priceAccordingToRoute = rate;
    print(rate);
    notifyListeners();
  }

  double calculateParcelCharge() {
    if (totalAmount > 250 && totalAmount < 10001) {
      return totalAmount * 0.1 + (totalAmount);
    } else if (totalAmount > 1001) {
      return totalAmount * 0.15 + (totalAmount);
    }
  }
}
