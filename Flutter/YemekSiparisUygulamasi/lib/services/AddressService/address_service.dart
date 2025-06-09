import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/AddressModel.dart';

class AddressContent {


  Future<List<Address>> GetAddress(int logicalref) async {
    final url = Uri.parse("$baseurl/api/Address/get/$logicalref");
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse.map((address) => Address.fromJson(address)).toList();
    } else {
      throw Exception("Ürünler gelmedi, başarısız");
    }
  }

  Future<void> PostAddress(Address address) async {
    final url = Uri.parse("$baseurl/api/Address/add/");
    final body = jsonEncode(address.toJson());
    final response =
        await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);
    if (response.statusCode == 200) {
      print("Addres Kaydı Başarılı");
    } else {
      print("Adres Kaydı Başarısız");
    }
  }

  Future<void> DeleteAddress(int logicalref) async {
    final url = Uri.parse("$baseurl/api/Address/delete/$logicalref");
    final response = await http.post(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print("Ürün Silindi");
    } else {
      print("Ürün Silinemedi.");
    }
  }
}
