import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/OrderDetailsModel.dart';
import 'package:shop_app/models/OrderModel.dart';

class OrderService {
  


  Future<int> orderpost(Order order) async {
    final url = Uri.parse("$baseurl/api/Order/add");
    final body = jsonEncode(order.toJson());

    final response =
        await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);

    if (response.statusCode != 200) {
      print("Hata Detayı:${response.body}");
    }
    if (response.statusCode == 200) {
      print("Gelen değer:${response.body}");
      return int.parse(response.body);
    } else {
      print("Sipariş kaydı oluşturulamadı");
      throw Exception("Sipariş Oluşturulamadı.");
    }
  }

  Future<void> orderDetailpost(OrderDetails orderDetails) async {
    final url = Uri.parse("$baseurl/api/Order/orderadd");
    final body = jsonEncode(orderDetails.toJson());

    final response =
        await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);
    if (response.statusCode == 200) {
      print("Gelen değer:${response.body}");
    } else {
      print("Sipariş detay kaydı oluşturulamadı");
      throw Exception("Sipariş Oluşturulamadı.");
    }
  }
}
