class Favorite {
  final int LOGICALREF;
  final int ACCOUNTREF;
  final int STOCKCARDREF;
  final String ADDEDDATE;

  Favorite({
    required this.LOGICALREF,
    required this.ACCOUNTREF,
    required this.STOCKCARDREF,
    required this.ADDEDDATE,
  });
  factory Favorite.fromJson(Map<String, dynamic> json) {
    print("LOGICALREF veri türü :${json['LOGICALREF'].runtimeType}");
    print("STOCKCARDREF veri türü :${json['STOCKCARDREF'].runtimeType}");
    print("AMOUNT veri türü :${json['ACCOUNTREF'].runtimeType}");
    print("UNITPRICE veri türü :${json['ADDEDDATE'].runtimeType}");

    return Favorite(
        LOGICALREF: json['LOGICALREF'],
        ACCOUNTREF: json['ACCOUNTREF'],
        STOCKCARDREF: json['STOCKCARDREF'],
        ADDEDDATE: json['ADDEDDATE']);
  }
  Map<String, dynamic> toJson() => {
        "LOGICALREF": LOGICALREF,
        "ACCOUNTREF": ACCOUNTREF,
        "STOCKCARDREF": STOCKCARDREF,
        "ADDEDDATE": ADDEDDATE,
      };
}
