import 'package:flutter/material.dart';

class Checks with ChangeNotifier {
  final List<String?> _check = [];

  List<String?> get check => _check;

  void addError({String? checks}) {
    if (!check.contains(checks)) {
      check.add(checks);
    }
    notifyListeners();
  }

  void removeError({String? checks}) {
    if (check.contains(checks)) {
      check.remove(checks);
    }
    notifyListeners();
  }

  void cleareror() {
    check.clear();
    notifyListeners();
  }
}
