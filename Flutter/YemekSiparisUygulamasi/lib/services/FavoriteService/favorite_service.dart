import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/FavoriteModel.dart';

class FavoriteService {
 

  Future<bool> postfavorite(Favorite favorite) async {
    final url = Uri.parse("$baseurl/api/Favorites/add");
    final body = jsonEncode(favorite.toJson());

    try {
      final response =
          await http.post(url, headers: {'Content-Type': 'application/json'}, body: body);
      if (response.statusCode == 200) {
        print("Gönderilen Model : $favorite");
        print("Başrılı");
        return true;
      } else {
        print("Başarısız :${response.body}");
        return false;
      }
    } catch (e) {
      print("hata: $e");
      return false;
    }
  }

  Future<bool> deletefavorite(int logicalref) async {
    final url = Uri.parse("$baseurl/api/Favorites/delete/$logicalref");
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print("Başrılı");
        return true;
      } else {
        print("Başarısız :${response.body}");
        return false;
      }
    } catch (e) {
      print("hata: $e");
      return false;
    }
  }
}
