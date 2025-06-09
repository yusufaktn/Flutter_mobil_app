import 'package:flutter/foundation.dart';
import 'package:shop_app/models/OrderModel.dart';
import 'package:shop_app/services/AccountService/product.service.dart';

class OrderState with ChangeNotifier {
  List<Order> _orders = [];
  List<Order> get orders => _orders;

  // var baseUrl = "https://192.168.1.152:7042";

  Future<void> fetch_order(int logicalref) async {
    int _logicalref = logicalref;
    try {
      _orders = await ApiProductContent().customerOrderProfile(_logicalref);
      print("Gelen ürünler $_orders");
    } catch (e) {
      print("Ürünler Yüklenemedi :$e");
    }

    notifyListeners();
  }
}
