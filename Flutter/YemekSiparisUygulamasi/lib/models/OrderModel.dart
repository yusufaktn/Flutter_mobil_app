import 'package:intl/intl.dart';

class Order {
  final int LOGICALREF;
  final int ACCOUNTREF;
  final String PAYMENTREF;
  final String ORDER_DATE_TIME;
  final String ORDER_TOTAL_PRICE;
  final String SHIP_ADDRESS;
  final String ORDER_STATUS;

  Order(
      {required this.LOGICALREF,
      required this.ACCOUNTREF,
      required this.PAYMENTREF,
      required this.ORDER_DATE_TIME,
      required this.ORDER_TOTAL_PRICE,
      required this.SHIP_ADDRESS,
      required this.ORDER_STATUS});

  factory Order.fromJson(Map<String, dynamic> json) {
    //final formatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    //final orderDateTime = (json['ORDER_DATE_TIME']);

    print("LOGICALREF veri türü :${json['LOGICALREF'].runtimeType}");
    print("ACCOUNTREF veri türü :${json['ACCOUNTREF'].runtimeType}");
    print("paymentref veri türü :${json['PAYMENTREF'].runtimeType}");
    print("ORDER_DATE_TIME veri türü :${json['ORDER_DATE_TIME'].runtimeType}");
    print("ORDER_TOTAL_PRICE veri türü :${json['ORDER_TOTAL_PRICE'].runtimeType}");
    print("SHIP_ADDRESS veri türü :${json['SHIP_ADDRESS'].runtimeType}");
    print("ORDER_STATUS veri türü :${json['ORDERSTATUS'].runtimeType}");

    String orderstatus(dynamic value) {
      if (value is int) {
        String newvalue = value.toString();
        if (newvalue == "0") {
          return value = "Sipariş oluşturuldu";
        }
        if (newvalue == "1") {
          return value = "İşleme Alındı";
        }
        if (newvalue == "2") {
          return value = "Sipariş Yolda";
        }
        if (newvalue == "3") {
          return value = "Sipariş tamamlandı";
        }
      }
      return value = "veri yok";
    }

    return Order(
        LOGICALREF: json['LOGICALREF'],
        ACCOUNTREF: json['ACCOUNTREF'],
        PAYMENTREF: json['PAYMENTREF'],
        ORDER_DATE_TIME: json['ORDER_DATE_TIME'],
        ORDER_TOTAL_PRICE: json['ORDER_TOTAL_PRICE'],
        SHIP_ADDRESS: json['SHIP_ADDRESS'],
        ORDER_STATUS: orderstatus(json['ORDERSTATUS']));
  }
  Map<String, dynamic> toJson() {
    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

    return {
      "LOGICALREF": LOGICALREF,
      "ACCOUNTREF": ACCOUNTREF,
      "PAYMENTREF": PAYMENTREF,
      "ORDER_DATE_TIME": ORDER_DATE_TIME,
      "ORDER_TOTAL_PRICE": ORDER_TOTAL_PRICE,
      "SHIP_ADDRESS": SHIP_ADDRESS,
      "ORDER_STATUS": ORDER_STATUS,
    };
  }
}
