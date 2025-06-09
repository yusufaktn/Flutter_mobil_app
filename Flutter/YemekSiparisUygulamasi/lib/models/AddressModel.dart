class Address {
  final int LOGICALREF;
  final int ACCOUNTREF;
  final String CITY;
  final String TOWN;
  final String DISTRICT;
  final String STREET;
  final String FLOOR_FLATNO;
  final String BUILD_NO;

  Address({
    required this.LOGICALREF,
    required this.ACCOUNTREF,
    required this.CITY,
    required this.TOWN,
    required this.DISTRICT,
    required this.STREET,
    required this.FLOOR_FLATNO,
    required this.BUILD_NO,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      LOGICALREF: json['LOGICALREF'] ?? 0,
      ACCOUNTREF: json['ACCOUNTREF'] ?? 0,
      CITY: json['CITY'] ?? "",
      TOWN: json['TOWN'] ?? "",
      DISTRICT: json['DISTRICT'] ?? "",
      STREET: json['STREET'] ?? "",
      FLOOR_FLATNO: json['FLOOR_FLATNO'] ?? "",
      BUILD_NO: json['BUILD_NO'] ?? "");

  Map<String, dynamic> toJson() => {
        "LOGICALREF": LOGICALREF,
        "ACCOUNTREF": ACCOUNTREF,
        "CITY": CITY,
        "TOWN": TOWN,
        "DISTRICT": DISTRICT,
        "STREET": STREET,
        "FLOOR_FLATNO": FLOOR_FLATNO,
        "BUILD_NO": BUILD_NO
      };

  @override
  String toString() {
    return "$DISTRICT, $STREET, $BUILD_NO, $FLOOR_FLATNO, $TOWN/$CITY";
  }
}
