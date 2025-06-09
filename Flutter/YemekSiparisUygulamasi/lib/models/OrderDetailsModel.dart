class OrderDetails {
  final STOCK_NAME;
  final int LOGICALREF;
  final int ORDERREF;
  final int STOCKCARDREF;
  final int AMOUNT;

  OrderDetails({
    required this.STOCK_NAME,
    required this.LOGICALREF,
    required this.ORDERREF,
    required this.STOCKCARDREF,
    required this.AMOUNT,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    /*
    print("STOCK_NAME veri türü :${json['STOCK_NAME'].runtimeType}");
    print("LOGICALREF veri türü :${json['LOGICALREF'].runtimeType}");
    print("ORDERREF veri türü :${json['ORDERREF'].runtimeType}");
    print("STOCKCARDREF veri türü :${json['STOCKCARDREF'].runtimeType}");
    print("AMOUNT veri türü :${json['AMOUNT'].runtimeType}");
    print("UNITPRICE veri türü :${json['UNITPRICE'].runtimeType}");*/

    return OrderDetails(
      STOCK_NAME: json['STOCK_NAME'],
      LOGICALREF: json['LOGICALREF'],
      ORDERREF: json['ORDERREF'],
      STOCKCARDREF: json['STOCKCARDREF'],
      AMOUNT: json['AMOUNT'],
    );
  }
  Map<String, dynamic> toJson() => {
        "LOGICALREF": LOGICALREF,
        "ORDERREF": ORDERREF,
        "STOCKCARDREF": STOCKCARDREF,
        "AMOUNT": AMOUNT,
      };
}
