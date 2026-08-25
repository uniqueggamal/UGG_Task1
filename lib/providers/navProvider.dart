import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  int currentIndex = 0;
  String subIndex = "Subjects";
  bool backState = false;
  void changeIndex(int index) {
    currentIndex = index;
    if (index != 1) {
      subIndex = "Subjects";
    }
    switchBack();
    notifyListeners();
  }

  void subjectIndex(String index) {
    if (currentIndex == 1) {
      subIndex = index;
    }
    switchBack();
    notifyListeners();
  }

  void defaultSubjectIndex() {
    subIndex = "Subjects";
    switchBack();
    notifyListeners();
  }

  void switchBack() {
    if (currentIndex == 1 && subIndex != "Subjects") {
      backState = true;
    } else {
      backState = false;
    }
  }
}
