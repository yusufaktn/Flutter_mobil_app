import 'package:flutter/foundation.dart';
import 'package:shop_app/models/OrderDetailsModel.dart';
import 'package:shop_app/services/AccountService/product.service.dart';

class OrderDetailState with ChangeNotifier {
  List<OrderDetails> _orderDetails = [];
  List<OrderDetails> get ordersDetails => _orderDetails;

  Future<void> fetch_orderdetails(int logicalref) async {
    int _logicalref = logicalref;
    try {
      _orderDetails = await ApiProductContent().OrderDetail(_logicalref);
      print("Gelen ürünler $_orderDetails");
    } catch (e) {
      print("Ürünler Yüklenemedi :$e");
    }

    notifyListeners();
  }
}
