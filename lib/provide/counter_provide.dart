import 'package:flutter/material.dart';

class CounterProvide with ChangeNotifier {
  int _value;

  int get value => _value;

  CounterProvide(this._value);

  void increment() {
    _value++;
    notifyListeners();
  }
}
