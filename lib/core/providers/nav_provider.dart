import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
