import 'package:flutter/material.dart';
import 'package:shop_app/models/CartModel.dart';

class CartState with ChangeNotifier {
  List<Cart> _cart = [];
  double total_toplam = 0.0;

  List<Cart> get cart => _cart;

  void adet_arttir(Cart cart) {
    cart.numOfItem++;
    notifyListeners();
  }

  void adet_azalt(Cart cart) {
    cart.numOfItem--;
    notifyListeners();
  }

  void update_total(Cart cart) {
    cart.total = cart.product.PRICE * cart.numOfItem;
    notifyListeners();
  }

  void update_tplam() {
    total_toplam = 0.0;
    for (var cart in _cart) {
      total_toplam += cart.total;
    }
    notifyListeners();
  }

  void clears() {
    _cart.clear();
    total_toplam = 0;
    notifyListeners(); 
  }

  void clear2(int index) {
    _cart.removeAt(index);
    update_tplam();
    notifyListeners();
  }
}
