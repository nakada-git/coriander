import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier{
  String cText = 'index';
  void changecText() {
    cText = 'imagine';
    notifyListeners();
  }
}