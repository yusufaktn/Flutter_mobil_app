import 'package:flutter/material.dart';
import 'package:shop_app/models/ProductModel.dart';
import 'package:shop_app/services/AccountService/product.service.dart';

class FavoriteState with ChangeNotifier {
  List<Product> _favoriteProduct = [];
  List<Product> get favoriteProduct => _favoriteProduct;

  bool isfavorite(int productref) {
    return favoriteProduct.any((element) => element.LOGICALREF == productref);
  }

  Future<void> fetch_favorite(int logicalref) async {
    int _logicalref = logicalref;
    try {
      _favoriteProduct = await ApiProductContent().Favorite_content(_logicalref);
      print("Gelen ürünler $_favoriteProduct");
    } catch (e) {
      print("Ürünler Yüklenemedi :$e");
    }

    notifyListeners();
  }
}
