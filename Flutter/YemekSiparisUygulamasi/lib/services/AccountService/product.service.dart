import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/OrderDetailsModel.dart';
import 'package:shop_app/models/OrderModel.dart';
import 'package:shop_app/models/ProductModel.dart';

class ApiProductContent {
  //Burada logicalref bazlı olmaksızın bütün ürünleri çeker.
  Future<List<Product>> product() async {
    final uri = Uri.parse("$baseurl/api/StockCard/");
    final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception("Başarısız");
    }
  }

//Burda da üürünleri çeker ama gelen json formatının içinden sadece StockCard bölümünü bulup  alır ve Product modele gönderir.
  Future<List<Product>> customerProfile(int logicalref) async {
    final uri = Uri.parse("$baseurl/api/Order/$logicalref");
    final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse
          .map((jsonItem) {
            if (jsonItem is Map<String, dynamic> && jsonItem.containsKey('StockCard')) {
              List<dynamic> stockCardJson = jsonItem['StockCard'];
              return stockCardJson.map((product) => Product.fromJson(product)).toList();
            } else {
              throw Exception("StockCard bölümü bulunamadı");
            }
          })
          .expand((productList) => productList)
          .toList();
    } else {
      throw Exception("Ürünler gelmedi, başarısız");
    }
  }

//OrderDetail tablasoundakileri getirir. Siparişin detaylarını getirir yine kendine ait OrderDetailState sınıfındaki listeye atar.
  Future<List<OrderDetails>> OrderDetail(int logicalref) async {
    final uri = Uri.parse("$baseurl/api/Order/$logicalref");
    final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse
          .map((jsonItem) {
            if (jsonItem is Map<String, dynamic> && jsonItem.containsKey('Details')) {
              List<dynamic> stockCardJson = jsonItem['Details'];
              return stockCardJson
                  .map((orderdetail) => OrderDetails.fromJson(orderdetail))
                  .toList();
            } else {
              throw Exception("Details bölümü bulunamadı");
            }
          })
          .expand((productList) => productList)
          .toList();
    } else {
      throw Exception("Ürünler gelmedi, başarısız");
    }
  }

//Müşteri siparişlerini getirir.Order Modele gönderirir. Ayrıca OrderState de liste içine atar.
  Future<List<Order>> customerOrderProfile(int logicalref) async {
    final uri = Uri.parse("$baseurl/api/Order/$logicalref");
    final response = await http.get(uri, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse.map((order) => Order.fromJson(order)).toList();
    } else {
      throw Exception("Ürünler gelmedi, başarısız");
    }
  }

//Favori ürünleri çekme
  Future<List<Product>> Favorite_content(int logicalref) async {
    final uri = Uri.parse("$baseurl/api/Favorites/$logicalref");
    final response = await http.get(uri, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      jsonResponse.map((e) {
        if (e is Map<String, dynamic> && e.containsKey('LOGICALREF')) {
          //String favorite_logicalref = e['LOGICALREF'];
        }
      });

      return jsonResponse
          .map((jsonItem) {
            if (jsonItem is Map<String, dynamic> && jsonItem.containsKey('StockCard')) {
              List<dynamic> favoriteJson = jsonItem['StockCard'];

              return favoriteJson.map((i) => Product.fromJson(i)).toList();
            } else {
              throw Exception("StockCard bölümü bulunamadı");
            }
          })
          .expand((productList) => productList)
          .toList();
    } else {
      throw Exception("Ürünler gelmedi, başarısız");
    }
  }

  /* Future<List> Favorite_content2(int logicalref) async {
    final uri = Uri.parse("$baseurl/api/Favorites/$logicalref");
    final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      // Favorite modellerini oluşturmak için bir liste
      List<Favorite> favorites = [];

      // Her bir JSON öğesini işleyin
      jsonResponse.forEach((e) {
        if (e is Map<String, dynamic> && e.containsKey('LOGICALREF')) {
          int favoriteLogicalref = e['LOGICALREF'];

          // StockCard verilerini al
          if (e.containsKey('StockCard')) {
            List<dynamic> stockCardJson = e['StockCard'];

            // Her StockCard için LOGICALREF ekleyin ve Product listesine dönüştürün
            List<Product> products = stockCardJson.map((i) {
              var productJson = i as Map<String, dynamic>;
              productJson['favoriteLogicalref'] = favoriteLogicalref; // LOGICALREF'yi ekleyin
              return Product.fromJson(productJson);
            }).toList();

            // Favorite modelini oluşturun ve listeye ekleyin
            favorites.add(Favorite(
              LOGICALREF: favoriteLogicalref,
              ACCOUNTREF: e['ACCOUNTREF'] ?? 0,
              STOCKCARDREF: e['STOCKCARDREF'] ?? 0,
              ADDEDDATE: e['ADDEDDATE'] ?? '',
              stockCardList: products,
            ));
          }
        }
      });

      // Tüm ürünleri tek bir liste olarak döndürün
      return favorites.expand((favorite) => favorite.stockCardList).toList();
    } else {
      throw Exception("Ürünler gelmedi, başarısız");
    }*/
}
