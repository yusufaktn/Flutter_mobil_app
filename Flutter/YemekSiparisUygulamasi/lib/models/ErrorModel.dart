import 'package:flutter/material.dart';

class Errors with ChangeNotifier {
  final List<String?> _eror = [];

  List<String?> get eror => _eror;

  void addError({String? error}) {
    if (!eror.contains(error)) {
      eror.add(error);
    }
    notifyListeners();
  }

  void removeError({String? error}) {
    if (eror.contains(error)) {
      eror.remove(error);
    }
    notifyListeners();
  }

  void cleareror() {
    eror.clear();
    notifyListeners();
  }
}
