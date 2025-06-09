import 'package:flutter/material.dart';

class AccountModel with ChangeNotifier {
  final int logicalref;
  final String name, surname, mail, password, tel;

  AccountModel(
      {required this.logicalref,
      required this.name,
      required this.surname,
      required this.mail,
      required this.password,
      required this.tel});

  AccountModel.withMailandPassword({required this.mail, required this.password})
      : logicalref = 0,
        name = "",
        surname = "",
        tel = "";

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
      logicalref: json['logicalref'] ?? 0,
      name: json['name'] ?? "",
      surname: json['surname'] ?? "",
      mail: json['mail'] ?? "",
      password: json['password'] ?? "",
      tel: json['tel'] ?? "");

  Map<String, dynamic> toJson() => {
        "logicalref": logicalref,
        "name": name,
        "surname": surname,
        "mail": mail,
        "password": password,
        "tel": tel
      };
}
