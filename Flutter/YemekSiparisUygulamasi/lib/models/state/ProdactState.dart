import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shop_app/models/OrderModel.dart';
import 'package:shop_app/models/ProductModel.dart';
import 'package:shop_app/services/AccountService/product.service.dart';

class ProductState with ChangeNotifier {
  List<Product> _Allproducts = [];
  List<Product> _products_customer = [];
  List<Order> _order_customer = [];

  List<Product> get Allproducts => _Allproducts;
  List<Product> get products_customer => _products_customer;
  List<Order> get order_customer => _order_customer;

  Future<void> fetchProducts() async {
    try {
      _Allproducts = await ApiProductContent().product();
      print("Gelen ürünler $_Allproducts");
    } catch (e) {
      print("Ürünler Yüklenemedi :$e");
    }

    notifyListeners();
  }

  Future<void> fetch_customerprofile(int logicalref) async {
    int _logicalref = logicalref;
    try {
      _products_customer = await ApiProductContent().customerProfile(_logicalref);
      print("Gelen ürünler $_products_customer");
    } catch (e) {
      print("Ürünler Yüklenemedi :$e");
    }

    notifyListeners();
  }

  /* Future<void> fetch_customerOrderProfile(int logicalref) async {
    int sayi = logicalref;
    try {
      await ApiProductContent().customerOrderProfile(sayi);
      print("Gelen ürünler $_order_customer");
    } catch (e) {
      print("Ürünler Yüklenemedi :$e");
    }

    notifyListeners();
  }*/
}
