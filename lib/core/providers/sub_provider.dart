import 'package:flutter/material.dart';

class SubProvider extends ChangeNotifier {
  String subIndex = 'Subjects';

  bool get backState => subIndex != 'Subjects';

  void subjectIndex(String index) {
    subIndex = index;
    notifyListeners();
  }

  void defaultSubjectIndex() {
    subIndex = 'Subjects';
    notifyListeners();
  }
}
