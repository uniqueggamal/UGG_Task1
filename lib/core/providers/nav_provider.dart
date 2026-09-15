import 'package:flutter/material.dart';
import 'package:internship_task/app/app_shell/base/screens/base_screen.dart';

class NavProvider extends ChangeNotifier {
  int currentIndex = 0;
  String subIndex = "Subjects";
  bool authState = false;

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

  void login() {
    authState = true;
    notifyListeners();
    
  }

  void logout() {
    authState = false;
    notifyListeners();
  }
}
