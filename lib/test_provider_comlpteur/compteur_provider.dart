import 'package:flutter/material.dart';

class CompteurProvider with ChangeNotifier {
  int _cpt = 0;
  int get cpt => _cpt;
  void incrementer() {
    _cpt++;
    //derniere ligne
    notifyListeners();
  }

  void decrementer() {
    _cpt--;
    notifyListeners();
  }
}
