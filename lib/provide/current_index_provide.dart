import 'package:flutter/material.dart';

class CurrentIndexProvide extends ChangeNotifier {
  int currentIndex = 0;

  changeCurrentIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
