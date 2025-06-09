import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/AccountModel.dart';
import 'package:shop_app/models/AddressModel.dart';
import 'package:shop_app/services/AccountService/login_service.dart';
import 'package:shop_app/services/AddressService/address_service.dart';

class UserState with ChangeNotifier {
  String _name = "";
  String _surname = "";
  String _email = "";
  String _telno = "";
  String _password = "";
  int _logicalref = 0;
  Address? _selectedAddress;
  Address? _geciciAddress;

  List<Address> _address = [];

  String get name => _name;
  String get email => _email;
  String get surname => _surname;
  String get password => _password;
  String get telno => _telno;
  Address? get selectedAddress => _selectedAddress;
  Address? get gecicidAddress => _geciciAddress;
  int get logicalref => _logicalref;

  List<Address> get address => _address;

  Future<void> saveLogicalRef(int logicalref) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('LOGICALREF', logicalref);
  }

  Future<void> fetch_address() async {
    try {
      _address = await AddressContent().GetAddress(_logicalref);
      print("Gelen ürünler $_address");
    } catch (e) {
      print("Ürünler Yüklenemedi :$e");
    }

    notifyListeners();
  }

  void setLogicalRef(int logicalref) {
    _logicalref = logicalref;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setTel(String tel) {
    _telno = tel;
    notifyListeners();
  }

  void setsurname(String surname) {
    _surname = surname;
    notifyListeners();
  }

  void setpassword(String password) {
    _password = password;
    notifyListeners();
  }

  void addAddress(Address address) {
    _address.add(address);
    notifyListeners();
  }

  void updateAddress(int index, Address newaddres) {
    _address[index] = newaddres;
    notifyListeners();
  }

  void removeAddress(int index) {
    _address.removeAt(index);
    notifyListeners();
  }

  void selectAddress(Address address) {
    _selectedAddress = address;
    notifyListeners();
  }

  void addressTemp(Address address) {
    _geciciAddress = address;
    notifyListeners();
  }

  Future<void> updateProfile(BuildContext context, ApiContent apiContent) async {
    try {
      await apiContent.updateProfile(
          AccountModel(
              logicalref: _logicalref,
              name: _name,
              surname: _surname,
              mail: _email,
              password: _password,
              tel: _telno),
          context);
    } catch (e) {
      print("Profil güncellenemedi: $e");
    }
  }
}
