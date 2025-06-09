import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/AccountModel.dart';
import 'package:shop_app/models/state/AccountState.dart';
import 'package:shop_app/screens/init_screen.dart';

class ApiContent {
 
  Future<void> login(String mail, String password, BuildContext context, Function addError) async {
    final url = Uri.parse("$baseurl/api/Account/login/$mail/$password");
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');

        if (response.body.isNotEmpty) {
          dynamic jsonData;
          try {
            jsonData = jsonDecode(response.body);
            print('JSON verisi çözüldü: $jsonData');
            print('JSON türü: ${jsonData.runtimeType}');
          } catch (e) {
            print('JSON verisi çözülemedi: $e');
          }
          if (jsonData != null && jsonData is Map<String, dynamic>) {
            try {
              final user_state = Provider.of<UserState>(context, listen: false);
              final logicalRef = jsonData['logicalref'];
              final name = jsonData['name'];
              final surname = jsonData['surname'];
              final email = jsonData['mail'];
              final tel = jsonData['tel'];
              final password = jsonData['password'];

              user_state.setLogicalRef(logicalRef);
              user_state.setName(name);
              user_state.setsurname(surname);
              user_state.setEmail(email);
              user_state.setTel(tel);
              user_state.setpassword(password);
              AccountModel user = AccountModel.fromJson(jsonData);
              print('Giriş Başarılı: ${user.mail}');

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InitScreen(),
                  ));
            } catch (e) {
              print('Giriş Başarılı ama kullanıcı bilgileri alınamadı: $e');
              addError(error: "Kullanıcı bilgileri alınamadı: $e");
            }
          } else {
            print('Giriş Başarılı ama kullanıcı bilgileri alınamadı.');
          }
        }
      } else {
        print('Giriş Yapılamadı: ${response.statusCode}');
        addError(error: kUserAccountError);
      }
    } catch (e) {
      print("Error: $e");
      addError(error: "Bağlantı hatası: $e");
    }
  }

  Future<void> register(AccountModel model, BuildContext context, Function adderror) async {
    final url = Uri.parse("$baseurl/api/Account/register/");
    dynamic body = jsonEncode(model.toJson());

    final response =
        await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);

    try {
      if (response.statusCode == 200) {
        print('Kullanıcı kaydedildi: ${response.body}');

        dynamic jsonData = jsonDecode(body);

        final user_state = Provider.of<UserState>(context, listen: false);
        final logicalRef = int.parse(response.body);
        final name = jsonData['NAME'];
        final surname = jsonData['SURNAME'];
        final email = jsonData['MAIL'];
        final tel = jsonData['TEL'];
        final password = jsonData['PASSWORD'];

        user_state.setLogicalRef(logicalRef);
        user_state.setName(name);
        user_state.setsurname(surname);
        user_state.setEmail(email);
        user_state.setTel(tel);
        user_state.setpassword(password);
        AccountModel user = AccountModel.fromJson(jsonData);
        print('Giriş Başarılı: ${user.mail}');
      } else {
        print('Kullanıcı kaydedilemedi: ${response.body}');

        var errorData = response.body;
        adderror(error: errorData);
        Navigator.pop(context);
        print("Json : $body");
      }
      if (body == null) {
        print("veri yok");
      }
    } catch (e) {
      print("eror :$e");
    }
  }

  Future<void> updateProfile(
    AccountModel updatemodel,
    BuildContext context,
  ) async {
    final url = Uri.parse("$baseurl/api/Account/register/");

    final body = jsonEncode(updatemodel.toJson());
    final response =
        await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);

    try {
      if (response.statusCode == 200) {
        print("Kullanıcı Güncellendi");
      } else {
        print("Kullanıcı Güncellenemedi");
      }
    } catch (e) {
      print("işlem başarız");
    }
  }

  static String? code;
  Future<void> sendemail(String email, String subject, String body) async {
    final url = Uri.parse("$baseurl/api/Account/send-verification-code/$email/$subject/$body");

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'toEmail': email,
        'subject': subject,
        'body': body,
      }),
    );

    if (response.statusCode == 200) {
      print("E-posta başarıyla gönderildi.");
      code = response.body.toString();
    } else {
      print("E-posta gönderimi başarısız: ${response.body}");
    }
  }
}
